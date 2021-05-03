#!/bin/bash

source components/common.sh

REPEAT

HEAD "Install Nginx"
apt install nginx -y
STAT $?

HEAD "Start Nginx Service"
systemctl enable nginx
systemctl start nginx
STAT $?

HEAD "Change directory and make todo directory and switch to todo directory"
cd /var/www/html && mkdir "todo" && cd todo || exit
STAT $?

HEAD "Install npm  & run build"
npm install
npm run build
STAT $?

HEAD "Change root path in nginx"
sed -i -e 's/(/var/www/html)/(/var/www/html/todo/frontend/dist' /etc/nginx/sites-available/default
STAT $?

HEAD "Update index.js File With Todo & Login Ip"
cd /var/www/html/todo/frontend && cd config || exit
vi index.js
sed -i -e
STAT $?

HEAD "Restart Nginx"
systemctl restart nginx
STAT $?

HEAD "run npm start"
npm start
STAT $?






HEAD"Install Npm"
apt install npm -y
