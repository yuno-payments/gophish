#!/bin/bash

echo "Update & Upgrade | Install Golang & GoPhish..."
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt update & sudo upgrade -y
sudo apt install golang-go unzip jq -y

# Install GoPhish
#wget https://github.com/gophish/gophish/releases/download/v0.11.0/gophish-v0.11.0-linux-64bit.zip
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
sudo mkdir /opt/gophish
sudo unzip gophish-v0.12.1-linux-64bit.zip -d /opt/gophish

echo "Install Certbot..."
sudo apt-get install python3-certbot-apache -y
sudo certbot --apache -d $RECORD_NAME --register-unsafely-without-email --agree-tos -n

echo "Copy the certs files..."
sudo cp /etc/letsencrypt/live/${RECORD_NAME}/privkey.pem /opt/gophish/
sudo cp /etc/letsencrypt/live/${RECORD_NAME}/fullchain.pem /opt/gophish/

echo "Change Config Files..."
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /opt/gophish/config.json
sudo sed -i 's/80/443/g' /opt/gophish/config.json
sudo sed -i 's/false/true/g' /opt/gophish/config.json
sudo sed -i 's/gophish_admin.key/privkey.pem/g' /opt/gophish/config.json
sudo sed -i 's/example.key/privkey.pem/g' /opt/gophish/config.json
sudo sed -i 's/gophish_admin.crt/fullchain.pem/g' /opt/gophish/config.json
sudo sed -i 's/example.crt/fullchain.pem/g' /opt/gophish/config.json

echo "Stop Apache2. Apache was used to Validate the certificate..."
sudo service apache2 stop

echo "Execute GoPhish..."
cd /opt/gophish
sudo chmod +x gophish
sudo ./gophish
