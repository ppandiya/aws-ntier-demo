resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "altimetrik-dev-vpc"
  }
}


/* Public Subnet Setup */

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
Name = "alti-demo-igw"

  }
}

/* Public subnet */
resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.default"]
  tags {
    Name = "public-subnet"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
  tags {

  Name = "alti-public-route-table"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}


/* Private subnet */
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = false
  depends_on = ["aws_instance.nat"]
  tags {
    Name = "private"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "private" {
  subnet_id = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}

/* Management subnet */

resource "aws_subnet" "mgmt" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.mgmt_subnet_cidr}"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = false
  depends_on = ["aws_instance.nat"]
  tags {
    Name = "Management"
  }
}


/* Associate the routing table to public subnet */
resource "aws_route_table_association" "mgmt" {
  subnet_id = "${aws_subnet.mgmt.id}"
  route_table_id = "${aws_route_table.private.id}"
}
