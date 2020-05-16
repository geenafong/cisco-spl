#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install nginx -y
wget https://raw.githubusercontent.com/geenafong/cisco-spl/master/index.html --output-document /usr/share/nginx/html/index.html
systemctl restart nginx