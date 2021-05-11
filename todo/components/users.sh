#!/bin/bash
source components/common.sh

Head "Set Hostname and Update repo"
REPEAT

Head "Install java-openjdk"
apt-get install openjdk-8-jdk-headless -y &>>"$LOG"
Stat $?

Head "Installing Maven"
apt install maven -y &>>"$LOG"
Stat $?

Head "Cloning the repo"
GIT_CLONE

Head "cleaning the maven package"
mvn clean package &>>"$LOG"

Head "Now move the user services"
mv /root/todo/users/users.service /etc/systemd/system/users.service

Head "Restart the services"
systemctl daemon-reload
systemctl start users.service
systemctl status users.service