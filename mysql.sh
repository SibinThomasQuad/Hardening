#!/bin/bash

# Set MySQL configuration file path
mysql_conf="/etc/mysql/mysql.conf.d/mysqld.cnf"

# Set recommended MySQL configuration options
config_options=(
    "bind-address = 127.0.0.1"
    "skip-networking"
    "skip-symbolic-links"
    "secure-file-priv = /var/lib/mysql-files"
    "max_connections = 100"
    "query_cache_type = 0"
    "query_cache_size = 0"
    "innodb_flush_log_at_trx_commit = 2"
    "innodb_file_per_table = 1"
    "innodb_buffer_pool_size = 256M"
    "innodb_log_file_size = 64M"
)

# Backup original MySQL configuration file
sudo cp $mysql_conf $mysql_conf.bak

# Apply recommended MySQL configuration options
for option in "${config_options[@]}"; do
    sudo sed -i "/^${option%% *}*/{s/=.*/= ${option#* = /}/}" $mysql_conf
done

# Restart MySQL service
sudo service mysql restart

echo "MySQL hardening complete."
