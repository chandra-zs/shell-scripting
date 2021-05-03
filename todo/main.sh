#!/bin/bash

COMPONENT=$1
 export LOG=/tmp/$"{COMPONENT}".log
 rm -f $LOG

if [ ! -f components/$"{COMPONENT}".sh ]; then
  echo "Invalid File"
  exit 1

fi

USERNAME=${whoami}

if [ $"{USERNAME" != "root" ]; then
  ERROR "u should be a root user to execute this script"
  exit 1

fi

export COMPONENT
bash components/$"{COMPONENT}".sh