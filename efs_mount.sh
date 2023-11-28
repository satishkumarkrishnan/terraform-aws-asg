#!/bin/bash
mkdir ~/efs-mount-point 
# Mounting Efs 
mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_hostname}:/  /tokyo-efs-mount
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport mount-target-DNS:/   ~/efs-mount-point  
# Making Mount Permanent
echo ${efs_hostname}:/ /var/www/html nfs4 defaults,_netdev 0 0  | cat >> /etc/fstab