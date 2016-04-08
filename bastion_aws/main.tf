provide "aws" {
  region = "${var.aws_region}"
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

aws_instance "bastion_box" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = false
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.bastion_box.id}"
  vpc_security_group_ids      = ["${var.security_group}"]
  tags                        = {}
}
