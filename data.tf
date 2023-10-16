data "aws_ami" "ami" {
  owners = ["amazon"]
  name_regex = "al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64"
}

data "aws_security_group" "fe_security_id" {
  filter {
    name   = "tag:Name"
    values = ["mumbai-sg-0"] # insert value here
  }
}

data "aws_security_group" "be_security_id" {
  filter {
    name   = "tag:Name"
    values = ["mumbai-sg-1"] # insert value here
  }
}

data "aws_subnet" "fe_subnet" {
  filter {
    name   = "tag:Name"
    values = ["mumbai-subnets-0"] # insert value here
  }
}

data "aws_subnet" "be_subnet" {
  filter {
    name   = "tag:Name"
    values = ["mumbai-subnets-1"] # insert value here
  }
}

data "aws_vpc" "mumbai_vpc" {
  filter {
    name   = "tag:Name"
    values = ["mumbai Virtual Private Cloud"] # insert value here
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}