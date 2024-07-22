variable "region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
  default     = "asg_cluster"
}

variable "ami" {
  description = "The AMI to run in the cluster"
  type        = string
  default     = "ami-02a405b3302affc24"   
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
  
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Only free tier is allowed: t2.micro | t3.micro."
  }
}

variable "desired_capacity" {
  description = "The desired number of EC2 Instances in the ASG"
  type        = number
  default     = 2
}
variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  default     = 2
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default     = true
}

variable "extra_tags" {
  default = [
    {
      key                 = "Foo"
      value               = "tokyo-instance-0"
      propagate_at_launch = true
    },
    {
      key                 = "Baz"
      value               = "tokyo-instance-1"
      propagate_at_launch = true
    },
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "target_group_arns" {
  description = "The ARNs of ELB target groups in which to register Instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "The type of health check to perform. Must be one of: EC2, ELB."
  type        = string
  default     = "EC2"

  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "The health_check_type must be one of: EC2 | ELB."
  }
}

variable "user_data" {
  description = "The User Data script to run in each Instance at boot"
  type        = string
  default     = null
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "allIPsCIDRblock" {
  default = "0.0.0.0/0"
}