#!/bin/bash

# Script Information (Optional)
##########################
# Script Name: Lamp Installer
# Author: Sunil Jangra
# Description: Installs and configures LAMP stack on Ubuntu/Debian systems.
##########################

# Check if running as root
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root"
  exit 1
fi

# Update package lists
apt update -y

# Install Apache
apt install apache2 -y

# Install MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password your_root_password'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password your_root_password'
apt install mysql-server -y

# Install PHP
apt install php libapache2-mod-php php-mysql -y

# Install PHPMyAdmin (optional)
apt install phpmyadmin -y
# Configure PHPMyAdmin (adjust paths as needed)
echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

# Restart Apache
systemctl restart apache2

echo "LAMP stack installed successfully!"
