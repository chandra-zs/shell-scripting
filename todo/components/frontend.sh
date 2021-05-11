#!/bin/bash

source components/common.sh

HEAD "Set hostname & update repo"
REPEAT

HEAD "Install Nginx"
apt install nginx -y &>>"${LOG}"

HEAD "Start Nginx"
systemctl start nginx

HEAD "Install Node & Nginx"
NPM
STAT $?

HEAD "switch to html directory"
cd /var/www/html || exit
STAT $?

#sudo find . -type d -name
# shellcheck disable=SC2181
#if [ $? -ne 0 ]; then
 #  mkdir
  # STAT $?
#fi
HEAD "make todo directory and switch"
mkdir vue && cd vue
STAT $?

HEAD "Clone code from Github"
GIT_CLONE
STAT $?

HEAD "Install Npm"
npm install &>>${LOG}
STAT $?

HEAD "Run build"
BUILD
STAT $?

HEAD "Change root path in nginx"
cd /etc/nginx/sites-available
sed -i -e 's+root /var/www/html+root /var/www/html/todo/frontend/dist+g' default

STAT $?

HEAD "Restart Nginx"
systemctl restart nginx
STAT $?

HEAD "run npm start"
npm start
STAT $?

