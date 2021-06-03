#!/bin/bash

COMPONENT=$1;

if [ -z "${COMPONENT}" ]; then
  echo "atleast one component name is required"
  exit 1

fi
LAUNCH_TEMPLATE_ID=lt-08bf8a3b7c53f50f8
VERSION=1
aws ec2 run-instances --launch-template LaunchTemplateId=${LAUNCH_TEMPLATE_ID},Version=${VERSION} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"