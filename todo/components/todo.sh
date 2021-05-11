#!/bin/bash

source components/common.sh

HEAD "Set hostname and update repo"
REPEAT
STAT $?

HEAD "Install npm"
NPM
STAT $?

HEAD "Clone code from github"
GIT_CLONE1
STAT $?

HEAD "Install npm"
npm install >>"${LOG}"
STAT $?

HEAD "Create service file"
mv systemd.service /etc/systemd/system/todo.service

HEAD "Start Todo Service"
systemctl daemon-reload && systemctl start todo && systemctl status todo
STAT $?

HEAD "NPM Start"
npm start