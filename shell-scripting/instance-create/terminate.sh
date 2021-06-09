#!/bin/bash

COMPONENT=$1
SPOT_INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].SpotInstanceRequestId|xargs -n1)
if [ -z "${SPOT_INSTANCE_ID}" ]; then
  echo "component name is wrong or empty"
  exit 1
fi
aws ec2 cancel-spot-instance-requests --spot-instance-request-ids ${SPOT_INSTANCE_ID}
INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].InstanceId|xargs -n1)
aws ec2 terminate-instances --instance-ids ${INSTANCE_ID}