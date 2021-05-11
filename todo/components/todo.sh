#!/bin/bash

source components/common.sh

HEAD "Set hostname and update repo"
REPEAT
STAT $?

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
mv /root/shell-scripting/todo/todo/systemd.service /etc/systemd/system/todo.service

HEAD "Replace Ip with DNS Names"
sed -i -e 's/Environment=REDIS_HOST=172.31.19.195/Environment=REDIS_HOST=redis.chandra1.online/g' /etc/systemd/system/todo.service
HEAD "Start Todo Service"
systemctl daemon-reload && systemctl start todo && systemctl status todo
STAT $?
