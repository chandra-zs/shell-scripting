#!/bin/bash

HEAD(){
  echo -e "\e[1;36m============================$1\e[0m"
  echo -e "\e[1;36m============================$1\e[0m" >>$"{LOG}"
}
UPDATE(){
  set-hostname $"{COMPONENT}"
  apt update
}

ERROR(){
  echo -e "\e[1;31m$1\e[0m"
}