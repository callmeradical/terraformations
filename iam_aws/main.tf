provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_iam_policy" "policy" {
  name   = "${var.policy_name}"
  policy = "file(${var.policy_path})"
}

resource "aws_iam_role" "role" {
  name = "${var.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "profile" {
  name  = "${var.profile_name}"
  roles = ["${aws_iam_role.role.name}"]
}

resource "aws_iam_policy_attachment" "role-attach" {
  name  = "role-attach"
  roles = ["${aws_iam_role.role.name}"]
}
