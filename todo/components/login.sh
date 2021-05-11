#!/bin/bash

source components/common.sh

HEAD "Set Hostname and Update Repo"
REPEAT
STAT $?

HEAD "Install Go Lang"
wget -c https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
STAT $?

HEAD "Set path variables"
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version
STAT $?

HEAD "Make directory"
mkdir ~/go
cd ~/go
mkdir src
cd src
STAT $?

HEAD "Clone code"
git clone "https://github.com/chandra-zs/login.git" &>>${LOG}
STAT $?

HEAD "Export go path in directory"
export GOPATH=~/go
depmod && apt install go-dep &>>$LOG
cd login
dep ensure && go get &>>$LOG && go build &>>$LOG
Stat $?

HEAD "Create login service file"
mv /root/go/src/login/systemd.service /etc/systemd/system/login.service

HEAD "Replace Ip with DNS Names"
sed –i –e 's/http://172.31.52.92:8080/http://users.chandra1.online:8080' /etc/systemd/system/login.service

HEAD "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?
