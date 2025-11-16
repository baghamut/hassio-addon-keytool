# Changelog

All notable changes to this project will be documented in this file.

## [1.0.6] - 2025-11-16
### Added
- Add repository.json so Home Assistant shows a proper repository name instead of "unknown" in the Add-on Store.

## [1.0.5] - 2025-11-16
### Changed
- Revert to Home Assistant base image ghcr.io/home-assistant/amd64-base:latest and remove custom image override for better Supervisor compatibility.
