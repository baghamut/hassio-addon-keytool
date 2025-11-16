#!/usr/bin/env bash
set -e

cp /ssl/privkey.pem /data/privkey.pem
cp /ssl/fullchain.pem /data/fullchain.pem

echo "Generating PKCS12 keystore from HAOS SSL certs..."
if [ ! -f /data/keystore.p12 ]; then
  openssl pkcs12 -export -in /data/fullchain.pem -inkey /data/privkey.pem -out /data/keystore.p12 -name "$KEY_ALIAS" -password pass:"$KEYSTORE_PASS"
fi

echo "Importing PKCS12 keystore into Java keystore..."
keytool -importkeystore -deststorepass "$KEYSTORE_PASS" -destkeypass "$KEYSTORE_PASS" -destkeystore "$KEYSTORE_FILE" -srckeystore /data/keystore.p12 -srcstoretype PKCS12 -alias "$KEY_ALIAS" -srcstorepass "$KEYSTORE_PASS" -noprompt

echo "Keystore is ready at $KEYSTORE_FILE"
echo "Add-on is now running..."

tail -f /dev/null
