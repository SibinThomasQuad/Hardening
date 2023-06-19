#!/bin/bash

# Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Enable firewall and allow only necessary services
echo "Configuring firewall..."
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow <additional_services>

# Disable unnecessary services
echo "Disabling unnecessary services..."
sudo systemctl disable <service_name>

# Disable root login and create a new user
echo "Disabling root login and creating a new user..."
sudo passwd -l root
sudo adduser <username>
sudo usermod -aG sudo <username>

# Set strong password policies
echo "Setting password policies..."
sudo sed -i 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS 90/g' /etc/login.defs
sudo sed -i 's/PASS_MIN_DAYS.*/PASS_MIN_DAYS 7/g' /etc/login.defs
sudo sed -i 's/PASS_WARN_AGE.*/PASS_WARN_AGE 7/g' /etc/login.defs

# Enable automatic security updates
echo "Enabling automatic security updates..."
sudo apt install unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades

# Disable root SSH login
echo "Disabling root SSH login..."
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo service ssh restart

# Set SSH key-based authentication
echo "Setting up SSH key-based authentication..."
mkdir ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo "<insert_public_key_here>" >> ~/.ssh/authorized_keys

# Disable unused network protocols
echo "Disabling unused network protocols..."
sudo sed -i 's/inet_protocols = all/inet_protocols = ipv4/g' /etc/postfix/main.cf
sudo sed -i 's/#net.ipv6.conf.all.disable_ipv6 = 1/net.ipv6.conf.all.disable_ipv6 = 1/g' /etc/sysctl.conf
sudo sysctl -p

# Enable auditing
echo "Enabling auditing..."
sudo apt install auditd
sudo systemctl enable auditd

# Configure secure shared memory
echo "Configuring secure shared memory..."
sudo echo "none /run/shm tmpfs defaults,rw,noexec,nosuid,nodev 0 0" >> /etc/fstab

echo "System hardening completed."
