# Specify the provider and access details
provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

/* Define our vpc */
resource "aws_vpc" "test" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "test-system"
  }
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "web" {
  name = "instance_sg_web_test"
  description = "WEB security group for Test"
  vpc_id = "${aws_vpc.test.id}"

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "WEB security group for Test"
  }
}

resource "aws_security_group" "elb" {
  name = "instance_sg_elb_test"
  description = "WEB security group for Test"
  vpc_id = "${aws_vpc.test.id}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "WEB security group for ELB"
  }
}
