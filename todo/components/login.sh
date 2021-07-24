#!/bin/bash

source components/common.sh

DOMAIN="chandra1.online"

HEAD "Set Hostname and Update Repo"
REPEAT
STAT $?

HEAD "Install Go Lang"
apt install golang -y &>>$LOG
Stat $?

DOWNLOAD_COMPONENT

Head "Extract Downloaded Archive"
cd /home/ubuntu && rm -rf login && unzip -o /tmp/login.zip &>>$LOG  && mv login-main login && cd /home/ubuntu/login && export GOPATH=/home/ubuntu/go && export GOBIN=$GOPATH/bin && go get &>>$LOG && go build
Stat $?

Head "Update EndPoints in Service File"
sed -i -e "s/user_endpoint/users.${DOMAIN}/" /home/ubuntu/login/systemd.service
Stat $?

HEAD "Move login service file"
mv /home/ubuntu/login/systemd.service /etc/systemd/system/login.service

HEAD "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?
