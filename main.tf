terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

module "vpc" {
  source ="git@github.com:satishkumarkrishnan/terraform-aws-vpc.git?ref=main"
}

resource "aws_key_pair" "deployer" {
  key_name   = "ec2-key"
  public_key = file("${path.module}/key")
}

resource "aws_launch_configuration" "tokyo_launch_config" {
  #count         = 2
  name_prefix   = "tokyo_asg"
  image_id      = var.ami
  instance_type = var.instance_type
  #user_data     = filebase64("${path.module}/user_data.sh")
  key_name      = "ec2-key"
  security_groups = [module.vpc.vpc_fe_sg]  
  user_data= <<-EOF # creating user Data  
#!/bin/bash
sudo su -
yum update -y
yum install httpd - y
service httpd start
yum install java -y
  EOF
}

resource "aws_autoscaling_group" "tokyo_asg" {
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  health_check_type      = "EC2"
  vpc_zone_identifier    = [module.vpc.vpc_fe_subnet.id, module.vpc.vpc_be_subnet.id]
  launch_configuration   = aws_launch_configuration.tokyo_launch_config.name
    }
    /*dynamic "tag" {
    for_each = data.aws_default_tags.tokyo_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
 }*/

 resource "aws_autoscaling_policy" "tokyo_asg_policy" {
  name                   = "tokyo-asg-policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tokyo_asg.name  
}