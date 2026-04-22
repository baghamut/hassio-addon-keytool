# Keytool Keystore Generator

Generates unifi.p12 from /ssl/*.pem on change. **New**: Auto-imports to UniFi Controller JKS.

## Config
- `password`: PKCS12 pass (13 chars default).
- `unifi_import`: Enable auto-import/restart (true).
- `unifi_pass`: UniFi keystore pass (aircontrolenterprise).
- `unifi_alias`: Cert alias (unifi).

## Usage
1. Add repo, install.
2. Mount /ssl (LE addon), /share.
3. Touch /ssl/fullchain.pem → auto p12 → UniFi import.

Universal: Detects any HA UniFi container ID dynamically.

Tested: HA Supervised, works your setup.
