data "aws_ami" "ami" {
  owners = ["amazon"]
  name_regex = "al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_instances" "tokyo_instances" {
  instance_tags = {
    SomeTag = "tokyo-instance"
  }
  instance_state_names = ["running", "stopped"]
}

data "aws_default_tags" "tokyo_tags" {
}