#!/bin/bash
sudo su - 
mkdir /tmp/efs
echo ${efs_hostname} >> /tmp/efs/efs_name
# Actually mount the EFS filesystem
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,soft,timeo=600,retrans=2 "${efs_hostname}:/" /tmp/efs
# Mounting Efs 
#mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_hostname}:/  ~/tokyo-efs-mount
#mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport "${efs_hostname}:/" /tmp/efs
#echo ${efs_hostname} > /tmp/dns.txt
#sudo cd /tokyo-efs-mount
#sudo ls -al
#sudo chmod go+rw .
#sudo touch test-file.txt  */
# Making Mount Permanent
#echo ${efs_hostname}:/ /var/www/html nfs4 defaults,_netdev 0 0  | cat >> /etc/fstab