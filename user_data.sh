#!/bin/bash
     #sudo su
     #yum update -y
     #yum install httpd -y
     #systemctl start httpd
     #systemctl enable httpd
     #echo "<h1>Terraform Learning from $(hostname -f)..</h1>" > /var/www/html/index.html 
     sudo su   
     apt-get install -y containerd - install containerd
     #sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/
     #sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg |sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes.gpg
     #sudo swapoff -a
     #sudo apt-get install -y containerd - install containerd
     
     #cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
     # overlay
     # br_netfilter
     # EOF

     #cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
     #net.bridge.bridge-nf-call-iptables  = 1
     #net.bridge.bridge-nf-call-ip6tables = 1
     #net.ipv4.ip_forward                 = 1
     #EOF

    # sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo  gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    #echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
     

     #sleep 10s
     #sudo sysctl --system - apply sysctl without reboot
     #sudo apt-get install -y containerd
     #sudo containerd config default | sudo tee /etc/containerd/config.toml
     #sudo sed -i 's/ SystemdCgroup = false/ SystemdCgroup = true/' /etc/containerd/config.toml
     #grep  'SystemdCgroup = true'  /etc/containerd/config.toml
     #sudo apt-get install -y apt-transport-https ca-certificates curl gpg