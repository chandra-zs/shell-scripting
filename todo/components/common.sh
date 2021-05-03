#!/bin/bash

HEAD(){
  echo -e "\e[1;36m =============================$1\e[0m"
  echo -e "\e[1;36m =============================$1\e[0m" >>"${LOG}"

}

REPEAT(){
  set-hostname "${COMPONENT}"
  HEAD "Updating apt repos"
  apt update >>"${LOG}"
}

ERROR(){
  echo -e "\e[1;31m$1\e[0m"
}

