#!/bin/bash

# Set PHP configuration file path
php_ini="/etc/php.ini"

# Set recommended PHP configuration options
config_options=(
    "expose_php = Off"
    "allow_url_fopen = Off"
    "allow_url_include = Off"
    "disable_functions = exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source"
    "disable_classes = "
    "upload_max_filesize = 10M"
    "post_max_size = 12M"
    "max_input_vars = 1000"
    "max_execution_time = 30"
    "session.cookie_httponly = 1"
    "session.use_only_cookies = 1"
)

# Backup original PHP configuration file
sudo cp $php_ini $php_ini.bak

# Apply recommended PHP configuration options
for option in "${config_options[@]}"; do
    sudo sed -i "/^;${option%% *}*/{s/^;//;s/=[[:space:]]*[^[:space:]]*/= ${option#* = /}/}" $php_ini
done

# Restart PHP service
sudo service php-fpm restart

echo "PHP hardening complete."
