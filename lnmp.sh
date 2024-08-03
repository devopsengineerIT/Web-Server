#!/bin/bash

# Script Information (Optional)
##########################
# Script Name: Lamp Installer
# Author: Sunil Jangra
# Description: Installs and configures LAMP stack on Ubuntu/Debian systems.
##########################

# Update package lists
sudo apt update

# Install Nginx
sudo apt install nginx -y

# Install MariaDB (or MySQL)
sudo apt install mariadb-server -y

# Secure MariaDB installation
sudo mysql_secure_installation

# Install PHP and required modules
sudo apt install php libapache2-mod-php php-mysql php-gd php-mbstring php-zip php-curl -y

# Configure PHP-FPM
sudo systemctl restart php7.4-fpm

# Create Nginx default site configuration (replace with your desired configuration)
cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80;
    server_name your_domain.com;

    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOF

# Enable the site
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Restart Nginx
sudo systemctl restart nginx

# Install PHPMyAdmin (optional)
sudo apt install phpmyadmin -y

# Configure PHPMyAdmin (optional)
# ...

# Additional configurations (optional)
# ...

echo "LNMP stack installation complete!"
