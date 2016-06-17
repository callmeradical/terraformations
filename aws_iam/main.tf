provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_iam_policy" "policy" {
  name   = "${var.policy_name}"
  policy = "${file(var.policy_path)}"
}

resource "aws_iam_role" "role" {
  name               = "${var.role_name}"
  assume_role_policy = "${file(var.assume_role_policy_path)}"
}

resource "aws_iam_instance_profile" "profile" {
  name  = "${var.profile_name}"
  roles = ["${aws_iam_role.role.name}"]
}

resource "aws_iam_policy_attachment" "role-attach" {
  name       = "role-attach"
  policy_arn = "${aws_iam_policy.policy.arn}"
  roles      = ["${aws_iam_role.role.name}"]
}
