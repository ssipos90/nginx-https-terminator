#!/usr/bin/env sh

set -eu

if [ -n "${SERVER_NAME:-}" ]; then
  echo "server_name ${SERVER_NAME};" > /etc/nginx/conf.d/default/server_name.conf
fi

DEFAULT_SUBJ="/CN=${SERVER_NAME:-*}/O=ssipos90/C=RO"

if [ ! -f /etc/nginx/certs/server.crt ] || [ ! -f /etc/nginx/certs/server.key ]; then
  echo "Certificates not found, generating self-signed certificates"
  SUBJ="${SUBJ:-$DEFAULT_SUBJ}"
  echo "Using SUBJ: ${SUBJ}"

  openssl req -x509 -nodes \
    -days 1825 \
    -newkey rsa:4096 \
    -keyout /etc/nginx/certs/server.key \
    -out /etc/nginx/certs/server.crt \
    -subj "${SUBJ}"
fi
