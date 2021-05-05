#!/bin/bash

source components/common.sh

REPEAT

HEAD "Install redis server"
sudo apt install redis-server -y >>"${LOG}"

HEAD "Change ip address in redis config file"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf

HEAD "Restart redis server"
systemctl restart redis