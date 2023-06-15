#!/bin/bash

# Set Apache configuration file path
apache_conf="/etc/apache2/apache2.conf"

# Set recommended Apache configuration options
config_options=(
    "ServerTokens Prod"
    "ServerSignature Off"
    "TraceEnable Off"
    "FileETag None"
)

# Backup original Apache configuration file
sudo cp $apache_conf $apache_conf.bak

# Apply recommended Apache configuration options
for option in "${config_options[@]}"; do
    sudo sed -i "s/^\(${option%% *}.*\)$/#\1\n${option}/" $apache_conf
done

# Enable necessary Apache modules
sudo a2enmod headers
sudo a2enmod expires
sudo a2enmod rewrite

# Restart Apache service
sudo service apache2 restart

echo "Apache hardening complete."
