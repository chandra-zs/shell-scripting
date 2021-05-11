#!/bin/bash
source components/common.sh

HEAD "Set Hostname and Update repo"
REPEAT

HEAD "Install java-openjdk"
apt-get install openjdk-8-jdk-headless -y &>>"$LOG"
Stat $?

HEAD "Installing Maven"
apt install maven -y &>>"$LOG"
Stat $?

HEAD "Cloning the repo"
GIT_CLONE

HEAD "cleaning the maven package"
mvn clean package &>>"$LOG"

HEAD "Now move the user services"
mv /root/shell-scripting/todo/users/systemd.service /etc/systemd/system/users.service

HEAD "Restart the services"
systemctl daemon-reload
systemctl start users.service
systemctl status users.service