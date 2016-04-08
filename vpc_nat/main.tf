provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "default" {
  cidr_block = "${var.default_vpc_cidr}"

  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_eip" "nat_a" {}

resource "aws_eip" "nat_b" {}

resource "aws_nat_gateway" "natgw_a" {
  allocation_id = "${aws_eip.nat_a.id}"
  subnet_id     = "${aws_subnet.public_a.id}"
  depends_on    = ["aws_internet_gateway.default"]
}

resource "aws_nat_gateway" "natgw_b" {
  allocation_id = "${aws_eip.nat_b.id}"
  subnet_id     = "${aws_subnet.public_b.id}"
  depends_on    = ["aws_internet_gateway.default"]
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_route_table" "private_a" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw_a.id}"
  }

  tags {
    Name = "${join(var.vpc_name, - A)}"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw_b.id}"
  }

  tags {
    Name = "${join(var.vpc_name, - B)}"
  }
}

resource "aws_route_table_association" "nat_gw_a" {
  subnet_id      = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.private_a.id}"
}

resource "aws_route_table_association" "nat_gw_b" {
  subnet_id      = "${aws_subnet.private_b.id}"
  route_table_id = "${aws_route_table.private_b.id}"
}

resource "aws_subnet" "public_a" {
  availability_zone       = "us-east-1a"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_a_subnet}"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_b" {
  availability_zone       = "us-east-1b"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_b_subnet}"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_a" {
  availability_zone       = "us-east-1a"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.private_a_subnet}"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_b" {
  availability_zone       = "us-east-1b"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.private_b_subnet}"
  map_public_ip_on_launch = false
}
