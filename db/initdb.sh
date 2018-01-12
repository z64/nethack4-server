#!/bin/bash
set -e

# Create user and DB
createdb -O nh4server nethack4

# Enable pgcrypto
psql -v ON_ERROR_STOP=1 --username "nh4server" -d nethack4 -c "CREATE EXTENSION pgcrypto"

