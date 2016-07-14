variable "access_key" { 
  description = "AWS access key"
}

variable "secret_key" { 
  description = "AWS secret access key"
}

variable "region"     { 
  description = "AWS region to host your network"
  default     = "us-west-1"
}

variable "instance_type" {
  description = "Type of instances to be launched"
  default = "t2.micro"
}

variable "small_instance_type" {
  description = "Type of instance to be launched for mesh base"
  default = "t2.small"
}

/* Ubuntu 14.04 amis by region */
variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-1 = "ami-049d8641" 
    us-east-1 = "ami-a6b8e7ce"
  }
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "192.168.1.0/24"
}
