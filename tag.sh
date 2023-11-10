#!/bin/bash
i=1
for INSTANCE in $(aws autoscaling describe-auto-scaling-instances --query AutoScalingInstances[].InstanceId --output text);
do
echo $INSTANCE	
aws ec2 create-tags --resources $INSTANCE --tags Key=Name,Value="tokyo_instance"$i
i=$((i+1));
echo $INSTANCE	
done