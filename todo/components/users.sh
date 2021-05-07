#!/bin/bash
source components/common.sh
OS_PREREQ
Head "Installing java8"
sudo apt-get install openjdk-8-jdk -y &>>"${LOG}"
java -version
Stat $?
Head "Installing maven"
apt install maven -y &>>"${LOG}"
Stat $?
Head "Adding user"
id todo &>>"${LOG}"
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
  useradd -m -s /bin/bash todo
  Stat $?
fi
cd /home/todo
Head "Remove Static Contents"
rm -rf users &>>"${LOG}"
Stat $?
Head "Downloading component"
GIT_CLONE

Head "Building and Running"
mvn clean package &>>"${LOG}" && chown todo:todo /home/todo -R &>>$LOG