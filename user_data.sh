#!/bin/bash
     sudo su
     yum update -y
     yum install httpd -y
     systemctl start httpd
     systemctl enable httpd
     echo "<h1>Terraform Learning from $(hostname -f)..</h1>" > /var/www/html/index.html