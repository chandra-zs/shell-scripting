#!/bin/bash

source components/common.sh

DOMAIN="chandra1.online"

HEAD "Set hostname & update repo"
REPEAT

HEAD "Install Nginx"
apt install nginx -y &>>${LOG}

HEAD "Start Nginx"
systemctl start nginx

HEAD "Install Node & Nginx"
NPM
STAT $?

DOWNLOAD_COMPONENT

Head "Extract Downloaded Archive"
cd /var/www/html && unzip -o /tmp/frontend.zip &>>$LOG && rm -rf frontend.zip && rm -rf frontend && mv frontend-main frontend && cd frontend
Stat $?

Head "update frontend configuration"
cd /var/www/html/frontend  && sudo npm install &>>$LOG && npm run build &>>$LOG
Stat $?

Head "Update Nginx Configuration"
mv todo.conf /etc/nginx/sites-enabled/todo.conf
for comp in login todo ; do
  sed -i -e "/$comp/ s/localhost/${comp}.${DOMAIN}/" /etc/nginx/sites-enabled/todo.conf
done
Stat $?

Head "ReStart Nginx service"
systemctl restart nginx
Stat $?