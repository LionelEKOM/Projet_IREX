#!/bin/bash

echo "###Installing certbot"
#apt install -y openssl certbot

echo "###Installing nginx"
#apt install -y nginx

chmod +x $PWD/frontend/nginx_conf.sh
source $PWD/frontend/nginx_conf.sh
#Create a symblink
ln -s /etc/nginx/sites-available/nextcloud_conf /etc/nginx/sites-enabled/
nginx -t
service nginx restart

