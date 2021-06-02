#!/bin/bash
source components/common.sh
HEAD "Installing nginx"

yum install nginx -y &>> /tmp/roboshop.log

STAT $?

#systemctl enable nginx >> /tmp/roboshop.log
#systemctl start nginx >> /tmp/roboshop.log