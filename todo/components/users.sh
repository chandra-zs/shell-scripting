#!/bin/bash

source components/common.sh

HEAD "Set hostname and update repo"
REPEAT
STAT $?

HEAD "Check java version and install java 8 version"
apt install openjdk-8-jdk
STAT $?

HEAD "Check java version"
java -version

HEAD "Clone Code From Github"
GIT_CLONE
STAT $?

HEAD "Create package"
#apt install maven >>"${LOG}"
mvn clean package >>"${LOG}"
STAT $?

#HEAD "Create jar file"
#java -jar target/users-api-0.0.1.jar >>"${LOG}"
#STAT $?

HEAD "Create Users Service"
vi /etc/systemd/system/users.service

HEAD "Start users service"
systemctl daemon-reload && systemctl start users && systemctl enable users
STAT $?