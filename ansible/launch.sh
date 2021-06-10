#!/bin/bash

COMPONENT=$1;
LAUNCH_TEMPLATE_ID=lt-08bf8a3b7c53f50f8
VERSION=3
HOSTZONE_ID=Z0436692C7FU5JVXITRX

if [ -z "${COMPONENT}" ]; then
  echo "component name is required"
  exit 1
fi

INSTANCE_CREATE() {
INSTANCE_STATE=$(aws --region us-east-1 ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].State.Name|xargs -n1)
if [ "${INSTANCE_STATE}" = "running" ]; then
    echo "Instance already created and running"
    exit 0
  elif [ "${INSTANCE_STATE}" = "stopped" ]; then
    echo "Instance is created but in stopped state"
    exit 0
fi
LAUNCH_TEMPLATE_ID=lt-08bf8a3b7c53f50f8
VERSION=3
aws ec2 --region us-east-1 run-instances --launch-template LaunchTemplateId=${LAUNCH_TEMPLATE_ID},Version=${VERSION} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"|jq
sleep 20
DNS_UPDATE

}

DNS_UPDATE() {
PRIVATEIP=$(aws --region us-east-1 ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].PrivateIpAddress|xargs -n1)
sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" record.json > /tmp/record.json
aws --region us-east-1 route53 change-resource-record-sets --hosted-zone-id ${HOSTZONE_ID} --change-batch file:///tmp/record.json | jq
}

if [ "${1}" == "all"  ]; then
  for component in frontend mongodb catalogue redis user cart mysql shipping rabbitmq payment ; do
    COMPONENT=${component}
    INSTANCE_CREATE
  done
  else
    COMPONENT=$1
    INSTANCE_CREATE
fi
