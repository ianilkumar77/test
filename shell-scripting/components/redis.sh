#!/bin/bash

source components/common.sh
rm -f /tmp/roboshop.log
set-hostname redis

HEAD "Install redis prerequisite applications" &>> /tmp/roboshop.log
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>> /tmp/roboshop.log && yum-config-manager --enable remi &>> /tmp/roboshop.log && yum install redis -y &>> /tmp/roboshop.log
STAT $?

HEAD "Update the BINIP from 127.0.0.1 to 0.0.0.0 in config file /etc/redis.conf" &>> /tmp/roboshop.log
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>> /tmp/roboshop.log
STAT $?

HEAD "Start Redis Database"
systemctl enable redis && systemctl start redis
STAT $?