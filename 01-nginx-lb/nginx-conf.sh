#!/usr/bin/env bash
set -euo pipefail

# install nginx
echo -e "\n🚀 Installing Nginx...\n"
sudo apt update && sudo apt install -y nginx

# start and enable nginx service
echo -e "\n🚀 Starting and Enabling Nginx service...\n"
sudo systemctl start nginx
sudo systemctl enable nginx

# copy custom nginx config file & create a symlink
echo -e "\n🚀 Copying Config File...\n"
sudo cp ./node-app.conf /etc/nginx/sites-available/
sudo ln -sf /etc/nginx/sites-available/node-app.conf /etc/nginx/sites-enabled/node-app.conf

# create self-signed SSL certificate
echo -e "\n🚀 Copying SSL Certificate & Key...\n"
sudo mv node-app-self-sign.crt /etc/ssl/certs/
sudo mv node-app-self-sign.key /etc/ssl/private/

# test and reload nginx
echo -e "\n🚀 Testing and Reloading Nginx...\n"

sudo nginx -t
sudo systemctl reload nginx

echo -e "\n\n✅ Nginx is Successfully Installed and Running.\n"

