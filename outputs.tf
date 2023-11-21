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

output "instance_id" {
  value = data.aws_instance.tokyo_test.id  
}

#VPC Outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_fe_subnet" {
  value = module.vpc.vpc_fe_subnet
}

output "vpc_be_subnet" {
  value = module.vpc.vpc_be_subnet
}

output "vpc_fe_sg" {
  value = module.vpc.vpc_fe_sg
}

output "vpc_be_sg" {
  value = module.vpc.vpc_be_sg
}

output "vpc_az1" {
  value = module.vpc.vpc_az[0]
}

output "vpc_az2" {
  value = module.vpc.vpc_az[1]
}

output "vpc_subnet" {
  value = module.vpc.vpc_fe_subnet.id
}