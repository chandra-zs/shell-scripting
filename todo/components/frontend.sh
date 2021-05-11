#!/bin/bash

source components/common.sh

HEAD "Set hostname & update repo"
REPEAT

#HEAD "Install Nginx"
#apt install nginx -y &>>"${LOG}"

HEAD "Start Nginx"
systemctl start nginx

HEAD "Install Node & Nginx"
NPM
STAT $?

HEAD "Change directory and make todo directory and switch to todo directory"
cd /var/www/html || exit
STAT $?

#sudo find . -type d -name
# shellcheck disable=SC2181
#if [ $? -ne 0 ]; then
 #  mkdir
  # STAT $?
#fi
 
mkdir -p todo && cd todo || exit
STAT $?

HEAD "Clone code from Github"
GIT_CLONE
STAT $?

HEAD "Install Npm"
npm install >>"${LOG}"
STAT $?

HEAD "Run build"
BUILD
killall node >>"${LOG}"
BUILD
STAT $?

HEAD "Change root path in nginx"
cd /etc/nginx/sites-available || exit
sed -i -e 's/\/var\/www\/html/\/var\/www\/html\/todo\/frontend\/dist/g' default
STAT $?

HEAD "Update index.js File With Todo & Login Ip"
cd /var/www/html/todo/frontend && cd config || exit
vi index.js
STAT $?

HEAD "Restart Nginx"
systemctl restart nginx
STAT $?

HEAD "run npm start"
npm start
STAT $?

