#!/bin/bash


TERMINATE_INSTANCE() {
aws --region us-east-1 ec2 cancel-spot-instance-requests --spot-instance-request-ids ${SPOT_INSTANCE_ID}
INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].InstanceId|xargs -n1)
aws --region us-east-1 ec2 terminate-instances --instance-ids ${INSTANCE_ID}
}


if [ "${1}" == "all"  ]; then
  for component in frontend mongodb catalogue redis user cart mysql shipping rabbitmq payment ; do
    COMPONENT=${component}
    TERMINATE_INSTANCE
  done
  else
    COMPONENT=$1
    TERMINATE_INSTANCE
fi

SPOT_INSTANCE_ID=$(aws --region us-east-1 ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].SpotInstanceRequestId|xargs -n1)
if [ -z "${SPOT_INSTANCE_ID}" ]; then
  echo "component name is wrong or empty"
  exit 1
fi
