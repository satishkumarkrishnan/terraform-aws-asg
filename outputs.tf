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