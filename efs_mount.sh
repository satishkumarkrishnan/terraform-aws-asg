#!/bin/bash
sudo su
mkdir /tokyo-efs-mount
# Mounting Efs 
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.tokyo_efs.dns_name}:/  /access/tokyo-efs-mount
# Making Mount Permanent
echo ${aws_efs_file_system.tokyo_efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab