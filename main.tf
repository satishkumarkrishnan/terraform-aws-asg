terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.2.0"
    }
  }
}

#module "vpc" {
#  source ="git@github.com:satishkumarkrishnan/terraform-aws-vpc.git?ref=main"
#}

#module "kms" {
#  source="git@github.com:satishkumarkrishnan/Terraform-KMS.git?ref=main"  
#}

resource "aws_key_pair" "deployer" {
  key_name   = "ec2-key"
  public_key = file("${path.module}/key")
}

resource "aws_launch_template" "tokyo_launch_template" {
  #count         = 2
  name_prefix   = "tokyo_asg"
  image_id      = var.ami
  instance_type = var.instance_type  
  #efs_hostname = aws_efs_file_system.tokyo_efs.dns_name
  #user_data = "${base64encode(<<EOF
  #${templatefile("efs_mount.sh",{efs_hostname = aws_efs_file_system.tokyo_efs.dns_name})}    
  #EOF
#)}"   
  user_data = "${base64encode(<<-EOT
    echo "efs_hostname = ${aws_efs_file_system.tokyo_efs.dns_name}" > /tmp/efs_dns
  EOT
  )}"
  key_name      = "ec2-key"
  vpc_security_group_ids = [module.vpc.vpc_fe_sg]  
  depends_on = [aws_efs_file_system.tokyo_efs] 
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "tokyo_test"
    }
  } 
 
}

resource "aws_autoscaling_group" "tokyo_asg" {
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  health_check_type      = "EC2"
  vpc_zone_identifier    = [module.vpc.vpc_fe_subnet.id, module.vpc.vpc_be_subnet.id]
  launch_template {
      id      = aws_launch_template.tokyo_launch_template.id      
      version = "$Latest"
    }
  depends_on = [aws_efs_file_system.tokyo_efs]  

}

 resource "aws_autoscaling_policy" "tokyo_asg_policy" {
  name                   = "tokyo-asg-policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tokyo_asg.name  
  depends_on = [aws_efs_file_system.tokyo_efs] 
}