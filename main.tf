resource "aws_key_pair" "deployer" {
  key_name   = "ec2-key"
  public_key = file("${path.module}/key")
}

resource "aws_launch_template" "tokyo_launch_template" {
  name_prefix   = "tokyo_asg"
  image_id      = var.ami
  instance_type = var.instance_type
  user_data     = filebase64("${path.module}/user_data.sh")
  key_name      = "ec2-key"
  vpc_security_group_ids = [data.aws_security_group.fe_security_id.id]
}

resource "aws_autoscaling_group" "tokyo_asg" {
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  health_check_type    = "EC2"

  vpc_zone_identifier    = [data.aws_subnet.fe_subnet.id, data.aws_subnet.be_subnet.id]
    launch_template {
      id      = aws_launch_template.tokyo_launch_template.id
      version = "$Latest"
    }
 }

 resource "aws_autoscaling_policy" "tokyo_asg_policy" {
  name                   = "tokyo-asg-policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tokyo_asg.name
}

/*resource "aws_alb_target_group_attachment" "tokyo_tg_attachmentProdRegister" {
    count            = length(module.GetInstanceId)
    target_group_arn = var.TgroupArn
    target_id        = module.GetInstanceId.InstanceId[count.index]
    port             = var.TgPort 
}*/