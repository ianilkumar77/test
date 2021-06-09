!#/bin/bash

INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"|jq .Reservations[].Instances[].State.Name|xargs -n1)