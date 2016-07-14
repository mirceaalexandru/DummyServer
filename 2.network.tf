/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "test" {
  vpc_id = "${aws_vpc.test.id}"
}

/* Public subnet */
resource "aws_subnet" "test" {
  vpc_id            = "${aws_vpc.test.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "us-west-1c"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.test"]
  tags {
    Name = "public"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.test.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test.id}"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.test.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_eip" "web" {
  instance = "${aws_instance.test.id}"
  vpc      = true
}

