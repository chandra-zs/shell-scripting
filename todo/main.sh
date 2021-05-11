#!/bin/bash

COMPONENT=$1



source components/common.sh

if [ ! -f components/${COMPONENT}.sh ]; then
  ERROR "Invalid File"
  exit 1

fi

USER_NAME=$(whoami)

if [ "${USER_NAME}" != "root" ]; then
  ERROR "You should be a root user to execute these scripts"
  exit 1
fi


export COMPONENT
bash components/${COMPONENT}.sh