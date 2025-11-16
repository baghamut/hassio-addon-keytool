#!/usr/bin/env bash
set -e

# Load config options from environment variables or fallback to defaults
KEYSTORE_PASS="${KEYSTORE_PASSWORD:-changeit}"
KEY_ALIAS="${KEY_ALIAS:-mykey}"
KEYSTORE_FILE="${KEYSTORE_FILE:-/data/keystore.jks}"

echo "Generating PKCS12 keystore from HAOS SSL certs..."
if [ ! -f /data/keystore.p12 ]; then
  openssl pkcs12 -export -in /ssl/fullchain.pem -inkey /ssl/privkey.pem -out /data/keystore.p12 -name "$KEY_ALIAS" -password pass:"$KEYSTORE_PASS"
fi

echo "Importing PKCS12 keystore into Java keystore..."
keytool -importkeystore -deststorepass "$KEYSTORE_PASS" -destkeypass "$KEYSTORE_PASS" -destkeystore "$KEYSTORE_FILE" -srckeystore /data/keystore.p12 -srcstoretype PKCS12 -alias "$KEY_ALIAS" -srcstorepass "$KEYSTORE_PASS" -noprompt

echo "Keystore is ready at $KEYSTORE_FILE"
echo "Add-on is now running..."

# Keep the container alive so Home Assistant sees add-on as running
tail -f /dev/null
