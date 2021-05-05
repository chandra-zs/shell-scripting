#!/bin/bash

source components/common.sh

REPEAT

HEAD "Install npm"
NPM
STAT $?

HEAD "Clone code from github"
GIT_CLONE
STAT $?

HEAD "Install npm"
npm install >>"${LOG}"
STAT $?

HEAD "Create service file"
vi /etc/systemd/system/todo.service

HEAD "Start Todo Service"
systemctl daemon-reload && systemctl start todo && systemctl status todo
STAT $?