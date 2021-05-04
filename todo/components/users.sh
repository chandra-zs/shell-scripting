#!/bin/bash

source components/common.sh

HEAD "Set hostname and update repo"
REPEAT
STAT $?

HEAD "Install maven"
apt install maven
STAT $?

HEAD "Check java version and install java 8 version"
java -version
apt-get install openjdk-8-jdk >>"${LOG}"
STAT $?

HEAD "Clone Code From Github"
GIT_CLONE
STAT $?

HEAD "Create package"
mvn clean package
java -jar target/users-api-0.0.1.jar
STAT $?

HEAD "Create Users Service"
vi /etc/systemd/system/users.service

HEAD "Start users service"
systemctl daemon-reload && systemctl start users && systemctl enable users
STAT $?