#!/bin/bash
source components/common.sh
HEAD "Set hostname & update repo"
REPEAT
STAT $?

HEAD "Install GO"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local >>"${LOG}"
STAT $?

HEAD "Set path variables"
export PATH=$PATH:/usr/local/go/bin
# shellcheck disable=SC1090
source ~/.profile || exit
go version

HEAD "Make directory"
sudo find . -type d -name "go"
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
  mkdir "go"
  STAT $?
fi

HEAD "Change directory"
cd go || exit

sudo find go -type d -name "src"
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
  mkdir "src"
  STAT $?
fi

HEAD "Change directory"
cd src  || exit

HEAD "Clone code from github"
GIT_CLONE
STAT $?

HEAD "Build"
go get
go build >>"${LOG}"

#HEAD "Create login service file"
#cd /etc/systemd/system || exit
#vi login.service

#HEAD "Start login service"
#systemctl daemon-reload && systemctl start login && systemctl status login
#STAT $?

HEAD "Build"
cd /go/src/login
./login || exit