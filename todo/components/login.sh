#!/bin/bash
source components/common.sh
HEAD "Set hostname & update repo"
REPEAT
HEAD "Install GO"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

HEAD "Set path variables"
export PATH=$PATH:/usr/local/go/bin
source ~/.profile || exit
go version

HEAD "Make directory"
cd /go && cd src  || exit

HEAD "Clone code from github"
GIT_CLONE
STAT $?

HEAD "Build"
go get
go build

HEAD "Create login service file"
cd /etc/systemd/system || exit
vi login.service

HEAD "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?

HEAD "Build"
cd /go/src/login
./login || exit





