#!/bin/bash

source components/common.sh

HEAD "Set hostname & update repo"
REPEAT

HEAD "Install GO"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

HEAD "Set path variables"
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
go version

HEAD "Make directory"
mkdir /go
cd /go
mkdir src
cd src

HEAD "Clone code from github"
GIT_CLONE

HEAD "Build"
go get
go build
./login

HEAD "Create login service file"


HEAD "Start login service"
systemctl deamon-reload && systemctl start login && systemctl status login