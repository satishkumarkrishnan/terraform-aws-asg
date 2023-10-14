data "aws_ami" "ami" {
  name_regex = "al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64"
}

data "aws_security_group" "fe_security_id" {
  filter {
    name   = "tag:Name"
    values = ["tokyo-sg-0"] # insert value here
  }
}

data "aws_security_group" "be_security_id" {
  filter {
    name   = "tag:Name"
    values = ["tokyo-sg-1"] # insert value here
  }
}

data "aws_subnet" "fe_subnet" {
  filter {
    name   = "tag:Name"
    values = ["tokyo-subnets-0"] # insert value here
  }
}

data "aws_subnet" "be_subnet" {
  filter {
    name   = "tag:Name"
    values = ["tokyo-subnets-1"] # insert value here
  }
}

data "aws_vpc" "tokyo_vpc" {
  filter {
    name   = "tag:Name"
    values = ["Tokyo Virtual Private Cloud"] # insert value here
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}