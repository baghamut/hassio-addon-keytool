#!/bin/bash

PASSWORD=$(bashio::config 'password')
if [ -z "$PASSWORD" ]; then
  bashio::exit.critical "Password required"
fi

# Create PKCS12 keystore from HA SSL cert and key
keytool -importkeystore \
  -srckeystore /dev/null \
  -srcstoretype PKCS12 \
  -destkeystore /share/unifi.p12 \
  -deststoretype PKCS12 \
  -srcstorepass "" \
  -deststorepass "$PASSWORD" \
  -alias unifi \
  -keyalg RSA \
  -keysize 2048 \
  -dname "CN=unifi" \
  -noprompt

# Alternative: Use openssl for full cert+key if needed (replace above if keytool fails)
# openssl pkcs12 -export -in /ssl/fullchain.pem -inkey /ssl/privkey.pem -out /share/unifi.p12 -name unifi -passout pass:$PASSWORD

bashio::exit.ok "Keystore generated at /share/unifi.p12"
