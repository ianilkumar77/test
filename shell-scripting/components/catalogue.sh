#!/bin/bash
source components/common.sh
rm -f /tmp/roboshop.log

HEAD "Installing nodejs make and gcc-c++"
yum install nodejs make gcc-c++ -y &>>/tmp/roboshop.log
STAT $?


HEAD "Creating roboshop user"
useradd roboshop &>>/tmp/roboshop.log
STAT $?

HEAD "Downloading the Catalogue application from git hub"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Unzipping the Catalogue application"
cd /home/roboshop && unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
STAT $?

HEAD "Installing the nodejs dependent application"
mv catalogue-main catalogue && cd /home/roboshop/catalogue && npm install --unsafe-perm &>>/tmp/roboshop.log
STAT $?



