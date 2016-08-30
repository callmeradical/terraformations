provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_security_group" "client" {
  name        = "${var.security_group_name}"
  description = "Allow ssh access"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_from}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${var.security_group_name}"
    Project   = "${var.project}"
    Terraform = "true"
  }
}

resource "aws_iam_instance_profile" "client" {
  name  = "${var.iam_role_name}"
  roles = ["${aws_iam_role.role.name}"]
}

resource "aws_iam_role" "role" {
  name = "${var.iam_role_name}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {"AWS": "*"},
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_instance" "client" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = false
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.client.id}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${aws_security_group.client.id}"]

  tags = {
    Name      = "${var.name}"
    Project   = "${var.project}"
    Terraform = "true"
  }
}
