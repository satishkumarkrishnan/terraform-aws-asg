output "asg_name" {
  value = aws_autoscaling_group.tokyo_asg.name
}

output "asg_alb_name" {
  value = aws_lb.test.name
}

output "asg_alb_arn" {
  value = aws_lb.test.arn
}

output "asg_alb_dns_name" {
  value = aws_lb.test.dns_name
}

output "asg_policy_arn" {
  value = aws_autoscaling_policy.tokyo_asg_policy.arn
}

output "asg_alb_hosted_zone_id" {
  value = aws_lb.test.zone_id
}


output "ec2_InstanceId" {
    value = data.aws_instances.tokyo_instances.id
    description = "get ec2 instance value id"
}