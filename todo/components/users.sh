#!/bin/bash

source components/common.sh
Head "Set hostname and update repo"
REPEAT
STAT $?

Head "install java 8 version"
apt-get install openjdk-8-jdk -y &>>"${LOG}"
STAT $?

Head "check java version"
java -version
STAT $?

Head "Install maven"
apt install maven -y &>>"${LOG}"
STAT $?
GIT_CLONE
STAT $?

Head "Create package"
mvn clean package
STAT $?

Head "Create Users Service"
vi /etc/systemd/system/users.service

Head "Start users service"
systemctl daemon-reload && systemctl start users && systemctl enable users
STAT $?
