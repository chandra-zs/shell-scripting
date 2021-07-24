#!/bin/bash

source components/common.sh

HEAD "Set Hostname and Update repo"
REPEAT
Stat $?

HEAD "Install java-openjdk"
apt-get install openjdk-8-jdk-headless -y &>>${LOG}
Stat $?

HEAD "Installing Maven"
apt install maven -y &>>${LOG}
Stat $?

DOWNLOAD_COMPONENT

Head "Extract Downloaded Archive"
cd /home/ubuntu && rm -rf users && unzip -o /tmp/users.zip &>>$LOG && mv users-main users  && cd users && mvn clean package &>>$LOG && mv target/users-api-0.0.1.jar users.jar
Stat $?

HEAD "Now move the user services"
mv /home/ubuntu/users/systemd.service /etc/systemd/system/users.service
Stat $?


HEAD "Restart the services"
systemctl daemon-reload && systemctl start users && systemctl status users
Stat $?