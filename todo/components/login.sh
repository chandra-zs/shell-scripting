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
mkdir -p go && cd /go && mkdir -p src && cd src || exit
STAT $?

HEAD "Clone code"
GIT_CLONE
STAT $?

HEAD "Export go path in directory"
export GOPATH=/go
go get github.com/dgrijalva/jwt-go
go get github.com/labstack/echo
go get github.com/labstack/echo/middleware
go get github.com/labstack/gommon/log
go get github.com/openzipkin/zipkin-go
go get github.com/openzipkin/zipkin-go/middleware/http
go get  github.com/openzipkin/zipkin-go/reporter/http
Stat $?

HEAD "Build"
go build &>>"${LOG}"
STAT $?

HEAD "Create login service file"
mv systemd.service /etc/systemd/system/login.service

HEAD "Start login service"
systemctl daemon-reload && systemctl start login && systemctl status login
STAT $?
