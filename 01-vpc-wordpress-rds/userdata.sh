#!/bin/bash
# -----------------------------
# WordPress EC2 Setup Script
# -----------------------------

# Log user-data output for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Force IPv4 for apt
sudo apt update -o Acquire::ForceIPv4=true && sudo apt install -o Acquire::ForceIPv4=true -y libapache2-mod-php

# Update OS packages
apt-get update -y
apt-get upgrade -y

# Install necessary packages
apt-get install -y apache2 php php-mysql wget unzip curl jq

# Install AWS CLI v2 (latest official package from AWS)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install

# Download and configure WordPress
wget https://wordpress.org/latest.tar.gz -P /tmp
tar -xzf /tmp/latest.tar.gz -C /tmp
rm -rf /var/www/html/*
cp -r /tmp/wordpress/* /var/www/html/

# Configure WordPress to connect to RDS
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Fetch DB credentials from Secrets Manager
# Replace 'wp-db-secret' with your Secrets Manager secret name
DB_SECRET_NAME="wordpress-creds"
DB_SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id $DB_SECRET_NAME --query SecretString --output text)

DB_NAME=$(echo $DB_SECRET_JSON | jq -r '.db_name')
DB_USER=$(echo $DB_SECRET_JSON | jq -r '.username')
DB_PASSWORD=$(echo $DB_SECRET_JSON | jq -r '.password')
DB_HOST=$(echo $DB_SECRET_JSON | jq -r '.db_host')

# Configure wp-config.php
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_HOST/" /var/www/html/wp-config.php

# Set unique security keys (optional, auto-generated)
SALT_KEYS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
sed -i "/AUTH_KEY/d" /var/www/html/wp-config.php
sed -i "/SECURE_AUTH_KEY/d" /var/www/html/wp-config.php
sed -i "/LOGGED_IN_KEY/d" /var/www/html/wp-config.php
sed -i "/NONCE_KEY/d" /var/www/html/wp-config.php
echo "$SALT_KEYS" >> /var/www/html/wp-config.php

# Set permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Start Apache service
systemctl enable apache2
systemctl start apache2
