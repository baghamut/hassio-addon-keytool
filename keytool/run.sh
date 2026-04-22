#!/bin/bash
set -e

# Load config
PKCS_PASS="${PASSWORD:-Password}"
UNIFI_IMPORT="${UNIFI_IMPORT:-true}"
UNIFI_PASS="${UNIFI_PASS:-aircontrolenterprise}"
UNIFI_ALIAS="${UNIFI_ALIAS:-unifi}"

echo "Keytool started: Using password: ${PKCS_PASS:0:3}*** ($((${#PKCS_PASS})) ) - Watching /ssl for cert changes"

inotifywait -m -e create,modify,move /ssl --format '%w%f' --recursive | while read FILE; do
  if [[ "$FILE" == *.pem ]]; then
    echo "Cert change detected - Generating PKCS12 keystore from /ssl certs..."
    
    # Generate PKCS12 (your original logic)
    openssl pkcs12 -export -in /ssl/fullchain.pem -inkey /ssl/privkey.pem \
      -out /share/unifi.p12 -name unifi -passout pass:"$PKCS_PASS" \
      -macalg sha256 -maciter 2048
    
    echo "Success: Keystore regenerated at /share/unifi.p12 ($(date))"
    
    # Universal UniFi auto-import
    if [ "$UNIFI_IMPORT" = "true" ]; then
      UNIFI_ID=$(docker ps --filter "ancestor=ghcr.io/hassio-addons/unifi" --format "{{.ID}}" | head -1)
      if [ -n "$UNIFI_ID" ]; then
        echo "UniFi ID: $UNIFI_ID - Importing..."
        docker cp /share/unifi.p12 "$UNIFI_ID:/tmp/unifi.p12"
        docker exec "$UNIFI_ID" sh -c "
          cd /usr/lib/unifi/data/ &&
          rm -f keystore.* &&
          keytool -importkeystore -noprompt \\
                  -srckeystore /tmp/unifi.p12 -srcstoretype PKCS12 -srcstorepass '$PKCS_PASS' \\
                  -destkeystore keystore -deststoretype JKS -deststorepass '$UNIFI_PASS' \\
                  -srcalias '$UNIFI_ALIAS' -destalias '$UNIFI_ALIAS' -destkeypass '$UNIFI_PASS' &&
          chown unifi:unifi keystore && chmod 600 keystore &&
          rm /tmp/unifi.p12
        "
        docker restart "$UNIFI_ID"
        echo "UniFi keystore imported & restarted"
      else
        echo "No hassio-addons/unifi container - skipping import"
      fi
    fi
  fi
done
