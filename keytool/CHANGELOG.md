# Changelog

## 1.0.10
- Disable init to avoid `s6-overlay-suexec: fatal: can only run as pid 1`.
- Remove conflicting OpenSSL package installation from Dockerfile.
- Keep PKCS12 keystore generation and UniFi restart behavior.

## 1.0.9
- Fix BUILD_FROM handling for Home Assistant add-on builds.
- Add build.yaml with base image mapping for supported architectures.
- Update Dockerfile for correct Home Assistant build flow.
- Keep automatic UniFi PKCS12 generation and import support.

## 1.0.8
- Add universal UniFi auto-import support.
- Improve certificate regeneration workflow.

## 1.0.7
- Previous release.
