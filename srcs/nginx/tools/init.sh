#!/bin/sh

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    echo "Generating SSL certificate..."

    mkdir -p /etc/ssl/certs

    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/ssl/certs/nginx.key \
        -out /etc/ssl/certs/nginx.crt \
        -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

echo "Starting NGINX..."
exec nginx -g "daemon off;"
