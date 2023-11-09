#!/bin/bash
     #sudo su
     #yum update -y
     #yum install httpd -y
     #systemctl start httpd
     #systemctl enable httpd
     #echo "<h1>Terraform Learning from $(hostname -f)..</h1>" > /var/www/html/index.html
     #ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
     #CURRENT_NAME=$(aws ec2 describe-tags --filters Name=resource-id,Values=${ID} Name=key,Values=Name --query Tags[].Value --output text
     #NEW_NAME=${CURRENT_NAME}-${ID}
     #aws ec2 create-tags --resources ${ID} --tags Key=Name,Value=${NEW_NAME}
i=1
for instance in $(aws autoscaling describe-auto-scaling-instances --query AutoScalingInstances[].InstanceId --output text);
do 
aws ec2 create-tags --resources $instance --tags Key=Name,Value=myInstance-$i
i=$((i+1));
done