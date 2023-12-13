#!/bin/bash
sudo su - 
dnf install -y nfs-utils
mkdir /tmp/efs
echo ${efs_hostname} >> /tmp/efs/efs_name
export efs_hostname=${efs_hostname}
systemctl enable --now nfs-server
# Actually mount the EFS filesystem
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,soft,timeo=600,retrans=2,noresvport "efs_hostname:/" /tmp/efs
# Mounting Efs 
#mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_hostname}:/  ~/tokyo-efs-mount
#mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport "${efs_hostname}:/" /tmp/efs
#sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0f4a48edafa2ea421.efs.ap-northeast-1.amazonaws.com:/ efs