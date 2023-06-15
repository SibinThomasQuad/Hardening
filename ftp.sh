#!/bin/bash

# Set vsftpd configuration file path
vsftpd_conf="/etc/vsftpd.conf"

# Set recommended vsftpd configuration options
config_options=(
    "anonymous_enable=NO"
    "local_enable=YES"
    "write_enable=YES"
    "chroot_local_user=YES"
    "allow_writeable_chroot=YES"
    "anon_upload_enable=NO"
    "anon_mkdir_write_enable=NO"
    "xferlog_enable=YES"
    "secure_chroot_dir=/var/run/vsftpd/empty"
    "connect_from_port_20=YES"
    "idle_session_timeout=300"
    "data_connection_timeout=300"
    "ftpd_banner=Welcome to the FTP server"
)

# Backup original vsftpd configuration file
sudo cp $vsftpd_conf $vsftpd_conf.bak

# Apply recommended vsftpd configuration options
for option in "${config_options[@]}"; do
    sudo sed -i "s/^\(${option%%=*}.*\)$/#\1\n${option}/" $vsftpd_conf
done

# Restart vsftpd service
sudo service vsftpd restart

echo "vsftpd hardening complete."
