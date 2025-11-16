#!/usr/bin/with-contenv bashio

# Get password from config
PASSWORD=$(bashio::config 'password')
if ! bashio::config.has_value 'password' || [ -z "$PASSWORD" ]; then
  bashio::exit.critical "Password required in configuration"
fi

# Check HA SSL certs exist
if [ ! -f "/ssl/fullchain.pem" ] || [ ! -f "/ssl/privkey.pem" ]; then
  bashio::exit.critical "HA SSL certs not found in /ssl (enable full SSL in Network settings: System > Network > HTTPS > fullchain.pem + privkey.pem)"
fi

# Generate PKCS12 keystore
bashio::info "Generating PKCS12 keystore from /ssl certs..."

openssl pkcs12 -export \
  -in /ssl/fullchain.pem \
  -inkey /ssl/privkey.pem \
  -out /share/unifi.p12 \
  -name unifi \
  -passout pass:$PASSWORD > /dev/null 2>&1

if [ $? -eq 0 ]; then
  bashio::info "Success: Keystore generated at /share/unifi.p12"
  bashio::exit.ok
else
  bashio::exit.critical "OpenSSL failed to generate keystore (check cert/key format or passphrase on privkey.pem)"
fi
