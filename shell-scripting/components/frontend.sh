#!/bin/bash

echo -e "\e[1m---------------------------------------"
echo -e "Installing nginx"
echo -e "-----------------------------------------\e[0m"

yum install nginx -y >> /tmp/roboshop.log

systemctl enable nginx >> /tmp/roboshop.log
systemctl start nginx >> /tmp/roboshop.log