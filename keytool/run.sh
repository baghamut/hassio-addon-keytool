#!/usr/bin/env bash

# Manual bashio setup (HA env vars from container)
export HASSIO_TOKEN=$HASSIO_TOKEN
export SUPERVISOR=$SUPERVISOR
source /usr/lib/hassio-addons/bashio 2>/dev/null || {
  echo "bashio not available, using fallback"
  bashio() { echo "fallback: $@" ; }
}

PASSWORD=$(bashio::config 'password')
if [ -z "$PASSWORD" ]; then
  echo "Password required in configuration"
  exit 1
fi

if [ ! -f "/ssl/fullchain.pem" ] || [ ! -f "/ssl/privkey.pem" ]; then
  echo "HA SSL certs not found in /ssl (enable full SSL in Network settings)"
  exit 1
fi

echo "Generating PKCS12 keystore from /ssl certs..."

openssl pkcs12 -export \
  -in /ssl/fullchain.pem \
  -inkey /ssl/privkey.pem \
  -out /share/unifi.p12 \
  -name unifi \
  -passout pass:$PASSWORD > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Success: Keystore generated at /share/unifi.p12"
  exit 0
else
  echo "OpenSSL failed to generate keystore - check certs/privkey"
  exit 1
fi
