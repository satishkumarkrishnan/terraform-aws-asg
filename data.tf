data "aws_ami" "ami" {
  owners = ["amazon"]
  name_regex = "al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_instance" "tokyo_test"{
 
  filter{
    name = "availability-zone"
    values = ["ap-northeast-1a"]
  }
 
  filter {
    name = "instance-state-name"
    values = ["running"]
  } 
  depends_on = [ module.vpc]
}