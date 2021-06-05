#!/bin/bash
source components/common.sh
rm -f /tmp/roboshop.log

HEAD "Installing nodejs make and gcc-c++"
yum install nodejs make gcc-c++ -y &>>/tmp/roboshop.log
STAT $?

CREATE_ROBOSHOP_USER

HEAD "Downloading the Catalogue application from git hub"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Unzipping the Catalogue application"
cd /home/roboshop && rm -rf catalogue && unzip -o /tmp/catalogue.zip &>>/tmp/roboshop.log && mv catalogue-main catalogue
STAT $?

HEAD "Installing the nodejs dependent application"
npm install --unsafe-perm &>>/tmp/roboshop.log
STAT $?

FIX_APP_PERMISSION



