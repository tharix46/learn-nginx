#!/usr/bin/env bash
set -euo pipefail

# check if script is run as root
if [[ $EUID -ne 0 ]]; then
  echo -e "\n❌ Run this script as root: sudo ./install-nginx.sh"
  exit 1
fi

# check for SSL certificate and key files
if [ ! -f "node-app-self-sign.crt" ] || [ ! -f "node-app-self-sign.key" ]; then
  echo -e "\n❌ SSL Certificate or Key not found! Please generate them before running this script.\n"

  echo -e "Use the following command to generate them:"
  echo -e "sudo openssl req -x509 -newkey rsa:2048 -nodes -keyout node-app-self-sign.key -out node-app-self-sign.crt -days 365\n"
  exit 1
fi

# install nginx
echo -e "\n🚀 Installing Nginx...\n"
apt update && apt install -y nginx

# start and enable nginx service
echo -e "\n🚀 Starting and Enabling Nginx service...\n"
systemctl start nginx
systemctl enable nginx

# copy custom nginx config file & create a symlink
echo -e "\n🚀 Copying Config File...\n"
cp ./node-app.conf /etc/nginx/sites-available/
ln -sf /etc/nginx/sites-available/node-app.conf /etc/nginx/sites-enabled/node-app.conf

# copy self-signed SSL certificate
echo -e "\n🚀 Copying SSL Certificate & Key...\n"
mv node-app-self-sign.crt /etc/ssl/certs/
mv node-app-self-sign.key /etc/ssl/private/

# test and reload nginx
echo -e "\n🚀 Testing and Reloading Nginx...\n"
nginx -t
systemctl reload nginx

# final status message
echo -e "\n\n✅ Nginx is Successfully Installed and Running.\n"

