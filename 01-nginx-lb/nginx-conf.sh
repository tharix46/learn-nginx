#!/usr/bin/env bash
set -euo pipefail

# install nginx
sudo apt update && sudo apt install -y nginx

# start and enable nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# copy custom nginx config file & create a symlink
sudo cp ./node-app.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/node-app.conf /etc/nginx/sites-enabled/
sudo nginx -t

# reload nginx
sudo nginx -s reload

echo "✅ Nginx installed and custom config applied!"

# update UFW rules to allow HTTP and HTTPS traffic
sudo ufw allow 'Nginx Full'
echo "✅ UFW rules (HTTP and HTTPS) updated for Nginx!"