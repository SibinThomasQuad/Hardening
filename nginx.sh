#!/bin/bash

# Set Nginx configuration file path
nginx_conf="/etc/nginx/nginx.conf"

# Set recommended Nginx configuration options
config_options=(
    "server_tokens off;"
    "client_max_body_size 10M;"
    "ssl_protocols TLSv1.2 TLSv1.3;"
    "ssl_prefer_server_ciphers on;"
    "ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';"
)

# Backup original Nginx configuration file
sudo cp $nginx_conf $nginx_conf.bak

# Apply recommended Nginx configuration options
for option in "${config_options[@]}"; do
    sudo sed -i "s/^\(${option%% *}.*\)$/#\1\n${option}/" $nginx_conf
done

# Test Nginx configuration
sudo nginx -t

# Restart Nginx service
sudo service nginx restart

echo "Nginx hardening complete."
