provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "default" {
  cidr_block = "${var.default_vpc_cidr}"

  tags {
    Name      = "${var.vpc_name}"
    Terraform = "true"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name      = "${var.vpc_name}"
    Terraform = "true"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_subnet" "public_a" {
  availability_zone       = "${var.az1}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_a_subnet}"
  map_public_ip_on_launch = true

  tags {
    Name      = "${var.vpc_name}-public-a"
    Terraform = "true"
  }
}

resource "aws_subnet" "public_b" {
  availability_zone       = "${var.az2}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_b_subnet}"
  map_public_ip_on_launch = true

  tags {
    Name      = "${var.vpc_name}-public-b"
    Terraform = "true"
  }
}

resource "aws_subnet" "private_a" {
  availability_zone       = "${var.az1}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.private_a_subnet}"
  map_public_ip_on_launch = false

  tags {
    Name      = "${var.vpc_name}-private-a"
    Terraform = "true"
  }
}

resource "aws_subnet" "private_b" {
  availability_zone       = "${var.az2}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.private_b_subnet}"
  map_public_ip_on_launch = false

  tags {
    Name      = "${var.vpc_name}-private-b"
    Terraform = "true"
  }
}
