#!/bin/bash

source components/common.sh

HEAD "Set hostname & update repo"
REPEAT

HEAD "Install Nginx"
apt install nginx -y &>>${LOG}

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
HEAD "Delete vue directory"
rm -rf vue


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
sed -i -e 's+root /var/www/html+root /var/www/html/vue/frontend/dist' /etc/nginx/sites-available/default
STAT $?

HEAD "Providing Login & Todo DNS names"
export AUTH_API_ADDRESS=http://login.chandra1.online:8080
export TODOS_API_ADDRESS=http://todo.chandra1.online:8080
HEAD "Restart Nginx"
systemctl restart nginx
STAT $?

HEAD "run npm start"
npm start
STAT $?

