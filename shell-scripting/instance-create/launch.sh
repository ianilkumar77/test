#!/bin/bash

COMPONENT=$1;

if [ -z "${COMPONENT}" ]; then
  echo "component name is required"
  exit 1
fi

INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].State.Name|xargs -n1)
if [ "${INSTANCE_STATE}" = "running" ]; then
  echo "Instance already created and running"
  exit 0
fi
LAUNCH_TEMPLATE_ID=lt-08bf8a3b7c53f50f8
VERSION=1
aws ec2 run-instances --launch-template LaunchTemplateId=${LAUNCH_TEMPLATE_ID},Version=${VERSION} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"|jq