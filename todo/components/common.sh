#!/bin/bash

HEAD(){
  echo -e "\e[1;36m =============================$1\e[0m"
  echo -e "\e[1;36m =============================$1\e[0m" >>"${LOG}"
}

STAT(){
  if [ "${1}" -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS\e[0m"
  else
    echo -e "\e[1;31m FAILURE\e[0m"
    echo  -e "\e[1m;31m Pls refer log file for more information, log filepath is =${LOG}\e[0m"

  fi
}
NPM(){
  apt install npm -y
}
GIT_CLONE(){
  git clone "https://github.com/zelar-soft-todoapp/${COMPONENT}.git"
  cd "${COMPONENT}" || exit
}
REPEAT(){
  set-hostname "${COMPONENT}"
  HEAD "Updating apt repos"
  apt update >>"${LOG}"
}
NPM_INSTALL(){
  npm install
}

ERROR(){
  echo -e "\e[1;31m$1\e[0m"
}

