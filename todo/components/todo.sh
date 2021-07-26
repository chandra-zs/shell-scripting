#!/bin/bash

source components/common.sh

DOMAIN="chandra1.online"

HEAD "Set hostname and update repo"
REPEAT
STAT $?

HEAD "Install npm"
NPM
STAT $?

DOWNLOAD_COMPONENT

HEAD "Extract Downloaded Archive"
cd /home/ubuntu && rm -rf todo && unzip -o /tmp/todo.zip &>>$LOG && mv todo-main todo  && cd todo && npm install &>>$LOG
STAT $?

HEAD "Update EndPoints in Service File"
sed -i -e "s/redis-endpoint/redis.${DOMAIN}/" /home/ubuntu/todo/systemd.service
STAT $?

HEAD "Move service file"
mv /home/ubuntu/todo/systemd.service /etc/systemd/system/todo.service

HEAD "Start Todo Service"
systemctl daemon-reload && systemctl start todo && systemctl status todo
STAT $?
