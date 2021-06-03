#!/bin/bash
source components/common.sh
rm /tmp/roboshop.log

HEAD "Setting up MongoDB Repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' > /etc/yum.repos.d/mongodb.repo
STAT $?

HEAD "Install MongoDB"
yum install -y mongodb-org &>> /tmp/roboshop.log
STAT $?

HEAD "Update IP Address in /etc/mongod.conf"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf  &>> /tmp/roboshop.log
STAT $?

HEAD "Enable  MongoDB service"
systemctl enable mongod   &>> /tmp/roboshop.log
STAT $?

HEAD "Start  MongoDB service"
systemctl start mongod   &>> /tmp/roboshop.log
STAT $?

HEAD "Download the Mongo DB Application from GIt Hub"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>> /tmp/roboshop.log
STAT $?

HEAD "Unzipping the Mongo DB Application"
cd /tmp && unzip -o mongodb.zip  &>> /tmp/roboshop.log
STAT $?

HEAD "Importing the Roboshop Schema"
cd mongodb-main  && mongo < catalogue.js &>> /tmp/roboshop.log
STAT $?
mongo < users.js  &>> /tmp/roboshop.log
STAT $?

HEAD "Enable  MongoDB service"
systemctl enable mongod   &>> /tmp/roboshop.log
STAT $?

HEAD "Start  MongoDB service"
systemctl restart mongod   &>> /tmp/roboshop.log
STAT $?



