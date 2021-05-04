#!/bin/bash

source components/common.sh

HEAD "Set hostname & update repo"
REPEAT

HEAD "Install GO"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local >>"${LOG}"
STAT $?

HEAD "Set path variables"
export PATH=$PATH:/usr/local/go/bin
# shellcheck disable=SC1090
source ~/.profile || exit
go version
STAT $?

HEAD "Make directory"
sudo find . -type d -name "go"
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
  mkdir "go"
  STAT $?
fi

sudo find . -type d -name "src"
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
  mkdir "src"
  STAT $?
fi
# mkdir /go && cd /go && mkdir src && cd src || exit

HEAD "Clone code from github"
GIT_CLONE
STAT $?

HEAD "Build"
go get
go build >>"${LOG}"
STAT $?

HEAD "Create login service file"
vi /etc/systemd/system/login.service


HEAD "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?

./login