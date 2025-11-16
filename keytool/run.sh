#!/usr/bin/env bash

# Read password from /data/options.json with jq
if [ ! -f "/data/options.json" ]; then
  echo "Config file /data/options.json not found - waiting for HA mount"
  sleep 30
  exit 1
fi

PASSWORD=$(jq -r '.password // empty' /data/options.json 2>/dev/null)
if [ -z "$PASSWORD" ]; then
  echo "Password required in configuration (/data/options.json empty)"
  cat /data/options.json
  sleep 30
  exit 1
fi

echo "Keytool started: Using password: ${PASSWORD:0:3}*** (length: ${#PASSWORD}) - Watching /ssl for cert changes"

# Function to generate keystore
generate_keystore() {
  if [ ! -f "/ssl/fullchain.pem" ] || [ ! -f "/ssl/privkey.pem" ]; then
    echo "Cert files not found in /ssl - waiting for Let's Encrypt add-on"
    return 1
  fi

  echo "Cert change detected - Generating PKCS12 keystore from /ssl certs..."

  openssl pkcs12 -export \
    -in /ssl/fullchain.pem \
    -inkey /ssl/privkey.pem \
    -out /share/unifi.p12 \
    -name unifi \
    -passout pass:$PASSWORD

  if [ $? -eq 0 ]; then
    echo "Success: Keystore regenerated at /share/unifi.p12 (timestamp: $(date))"
    # Optional: Verify inside
    openssl pkcs12 -info -in /share/unifi.p12 -passin pass:$PASSWORD | head -5
  else
    echo "OpenSSL failed - check /ssl certs or password"
    return 1
  fi
}

# Initial generation
generate_keystore

# Watch loop: Infinite for application mode; regenerate on /ssl/fullchain.pem modify
while true; do
  inotifywait -q -e modify /ssl/fullchain.pem 2>/dev/null || {
    echo "inotifywait failed - retrying in 60s"
    sleep 60
    continue
  }
  echo "Fullchain.pem modified - regenerating keystore"
  generate_keystore
  sleep 10  # Debounce
done
