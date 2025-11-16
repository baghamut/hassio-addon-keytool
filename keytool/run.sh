#!/usr/bin/env bash
set -e

echo "Keytool version:"
keytool -help

# Keep container running to allow exec access for keytool commands
tail -f /dev/null
