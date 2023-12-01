#!/bin/bash
sudo su - 
# Make sure all packages are up-to-date
yum update -y
# Make sure that NFS utilities and AWS CLI utilities are available
yum install -y jq nfs-utils python27 python27-pip awscli
pip install --upgrade awscli
EC2_REGION="ap-northeast-1"
# Creates the mount-point for the EFS filesystem
DIR_TGT="/tmp/efs"
mkdir "${DIR_TGT}"
# Name of the EFS filesystem (match what was created in EFS)
EFS_FILE_SYSTEM_NAME=${efs_hostname}

# Get the EFS filesystem ID.
EFS_FILE_SYSTEM_ID="$(/usr/local/bin/aws efs describe-file-systems --region "${EC2_REGION}" | jq '.FileSystems[]' | jq "select(.Name==\"${EFS_FILE_SYSTEM_NAME}\")" | jq -r '.FileSystemId')"
if [ -z "${EFS_FILE_SYSTEM_ID}" ]; then
    echo "ERROR: variable not set" 1> /etc/efssetup.log
    exit
fi
# Create the mount source path
DIR_SRC="${EFS_FILE_SYSTEM_ID}.efs.${EC2_REGION}.amazonaws.com"
# Actually mount the EFS filesystem
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,soft,timeo=600,retrans=2 "${DIR_SRC}:/" "${DIR_TGT}"
# Mounting Efs 
#mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_hostname}:/  ~/tokyo-efs-mount
echo ${efs_hostname} >> /tmp/efs/efs_name
#mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport "${efs_hostname}:/" /tmp/efs
#echo ${efs_hostname} > /tmp/dns.txt
#sudo cd /tokyo-efs-mount
#sudo ls -al
#sudo chmod go+rw .
#sudo touch test-file.txt  */
# Making Mount Permanent
#echo ${efs_hostname}:/ /var/www/html nfs4 defaults,_netdev 0 0  | cat >> /etc/fstab