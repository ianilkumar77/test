#!/bin/bash

source components/common.sh
rm -f /tmp/roboshop.log
set-hostname user

HEAD "install NodeJS in the system"
yum install nodejs make gcc-c++ -y &>> /tmp/roboshop.log
STAT $?

CREATE_ROBOSHOP_USER

INSTALL_APPLICATION user

FIX_APP_PERMISSION