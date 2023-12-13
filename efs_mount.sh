#!/bin/bash
sudo su - 
dnf install -y nfs-utils
mkdir /tmp/efs
echo ${efs_hostname} >> /tmp/efs/efs_name
systemctl enable --now nfs-server
# Mounting Efs 
echo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,soft,timeo=600,retrans=2,noresvport "$(cat /tmp/efs/efs_name):/" /tmp/efs >> /tmp/efs/efs_log
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,soft,timeo=600,retrans=2,noresvport "$(cat /tmp/efs/efs_name):/" /tmp/efs
sleep 60s