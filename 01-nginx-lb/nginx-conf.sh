#!/usr/bin/env bash
set -euo pipefail

echo -e "\n\n"

# install nginx
sudo apt update && sudo apt install -y nginx

# start and enable nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# copy custom nginx config file & create a symlink
sudo cp ./node-app.conf /etc/nginx/sites-available/
sudo ln -sf /etc/nginx/sites-available/node-app.conf /etc/nginx/sites-enabled/node-app.conf

# create self-signed SSL certificate
sudo mv node-app-self-sign.crt /etc/ssl/certs/
sudo mv node-app-self-sign.key /etc/ssl/private/

# test and reload nginx
sudo nginx -t
sudo systemctl reload nginx

echo -e "\n\n✅ Nginx successfully installed and running.\n"

