provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_security_group" "bastion" {
  name        = "bastion_ssh"
  description = "Allow ssh access"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_from}"]
  }

  tags {
    Name      = "Bastion security group"
    Project   = "${var.project}"
    Terraform = "true"
  }
}

resource "aws_iam_instance_profile" "bastion_box" {
  name  = "bastion_profile"
  roles = ["${aws_iam_role.role.name}"]
}

resource "aws_iam_role" "role" {
  name = "bastion_role"
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

resource "aws_instance" "bastion_box" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = false
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.bastion_box.id}"
  vpc_id                      = "${var.vpc_id}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]

  tags = {
    Name      = "${var.name}"
    Project   = "${var.project}"
    Terraform = "true"
  }
}
