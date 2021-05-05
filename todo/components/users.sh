#!/bin/bash

source components/common.sh

HEAD "Set hostname and update repo"
REPEAT
STAT $?

HEAD "Install maven"
apt install maven >>"${LOG}"
STAT $?

HEAD "Check java version and install java 8 version"
java -version
apt uninstall openjdk-11-jdk >>"${LOG}"
apt install openjdk-8-jdk -y >>"${LOG}"
STAT $?

HEAD "Clone Code From Github"
GIT_CLONE
STAT $?

HEAD "Create package"
mvn clean package >>"${LOG}"

HEAD "Create jar file"
java -jar target/users-api-0.0.1.jar
STAT $?

HEAD "Create Users Service"
vi /etc/systemd/system/users.service

HEAD "Start users service"
systemctl daemon-reload && systemctl start users && systemctl enable users
STAT $?