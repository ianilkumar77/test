#!/bin/bash
source components/common.sh

HEAD "Installing nginx \t"
yum install nginx -y &>> /tmp/roboshop.log
STAT $?

HEAD "Downloading the frontend application"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>> /tmp/roboshop.log
STAT $?

HEAD "Deploying the frontend application"
cd /usr/share/nginx/html && rm -rf * &>> /tmp/roboshop.log
STAT $?
HEAD "Unzipping the frontend application"
unzip /tmp/frontend.zip &>> /tmp/roboshop.log
STAT $?
mv frontend-main/* . && mv static/* . && rm -rf frontend-master README.md &>> /tmp/roboshop.log
STAT $?
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> /tmp/roboshop.log
STAT $?

HEAD "Starting Nginx \t"
systemctl enable nginx &>> /tmp/roboshop.log
STAT $?

HEAD "Enabling Nginx \t"
systemctl restart nginx &>> /tmp/roboshop.log
STAT $?

HEAD "Start systemd & start catalogue service"
systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue &>> /tmp/roboshop.log
STAT $?

