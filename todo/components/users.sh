#!/bin/bash

source components/common.sh

Head "Set hostname and update repo"
REPEAT
STAT $?

Head "install java 8 version"
# shellcheck disable=SC2024
sudo apt install openjdk-8-jdk -y &>>"${LOG}"
STAT $?

Head "check java version"
java -version
STAT $?

Head "Install maven"
sudo apt install maven
STAT $?

Head "Clone code"
git clone "https://github.com/chandra-zs/users.git" &>>"${LOG}"
  cd users ||  exit
STAT $?

Head "Create package"
mvn clean package
STAT $?

Head "Create Users Service"
mv systemd.service /etc/systemd/system/users.service

Head "Start users service"
systemctl daemon-reload && systemctl start users && systemctl enable users
STAT $?
