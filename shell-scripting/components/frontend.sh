#!/bin/bash
source components/common.sh
HEAD "Installing nginx"

yum install nginx -y &>> /tmp/roboshop.log

STAT $?

HEAD "Starting Nginx"
systemctl enable nginx &>> /tmp/roboshop.log
STAT $?
HEAD "Enabling Nginx"
systemctl start nginx &>> /tmp/roboshop.log
STAT $?

HEAD "Downloading the frontend application"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>> /tmp/roboshop.log
STAT $?

HEAD "Deploying the frontend application"
cd /usr/share/nginx/html && rm -rf * &>> /tmp/roboshop.log
STAT $?
unzip /tmp/frontend.zip
STAT $?
mv frontend-main/* . && mv static/* . && rm -rf frontend-master README.md &>> /tmp/roboshop.log
STAT $?
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> /tmp/roboshop.log
STAT $?



