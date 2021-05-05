#!/bin/bash

source components/common.sh

HEAD "Set hostname & update repo"
REPEAT

HEAD "Install GO"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
STAT $?

HEAD "Set path variables"
export PATH=$PATH:/usr/local/go/bin
# shellcheck disable=SC1090
source ~/.profile
go version
STAT $?

HEAD "Make directory"
cd /go && cd src  || exit

HEAD "Clone code from github"
GIT_CLONE
STAT $?

HEAD "Export go path"
export GOPATH=/go

HEAD "Build"
go get
go build &>>"${LOG}"
STAT$?

HEAD "Create login service file"
vi /etc/systemd/system/login.service || exit

HEAD "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?

#HEAD "Build"
#cd /go/src/login
#./login || exit





