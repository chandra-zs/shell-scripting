#!/bin/bash

LOG=/tmp/"${COMPONENT}".log
rm -rf "$(LOG)"

HEAD(){
  echo -e "\e[1;36m =============================$1===================\e[0m"
  echo -e "\e[1;36m =============================$1===================\e[0m" >>"${LOG}"
}



STAT(){
  if [ "${1}" -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS\e[0m"
  else
    echo -e "\e[1;31m FAILURE\e[0m"
    echo  -e "\e[1m;31m Pls refer log file for more information, log filepath is =${LOG}\e[0m"

  fi
}

DOWNLOAD_COMPONENT() {
  Head "Downloading ${COMPONENT} Component"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/chandra-zs/${COMPONENT}/archive/main.zip"
  Stat $?
}

NPM(){
  apt install npm -y >>${LOG}
}
BUILD(){
  npm run build >>${LOG}
}

REPEAT(){
  set-hostname "${COMPONENT}"
  HEAD "Updating apt repos"
  apt update >>${LOG}
}

ERROR(){
  echo -e "\e[1;31m$1\e[0m"
}

