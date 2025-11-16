#!/usr/bin/with-contenv bashio

PASSWORD=$(bashio::config 'password')
if ! bashio::config.has_value 'password' || [ -z "$PASSWORD" ]; then
  bashio::exit.critical "Password required in configuration"
fi

if [ ! -f "/ssl/fullchain.pem" ] || [ ! -f "/ssl/privkey.pem" ]; then
  bashio::exit.critical "HA SSL certs not found in /ssl (enable full SSL in Network settings)"
fi

echo "Generating PKCS12 keystore from /ssl certs..."

openssl pkcs12 -export   -in /ssl/fullchain.pem   -inkey /ssl/privkey.pem   -out /share/unifi.p12   -name unifi   -passout pass:$PASSWORD

if [ $? -eq 0 ]; then
  echo "Success: Keystore generated at /share/unifi.p12"
  bashio::exit.ok
else
  echo "OpenSSL failed to generate keystore - check certs/privkey"
  bashio::exit.critical "OpenSSL failed"
fi
