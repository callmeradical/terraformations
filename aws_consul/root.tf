provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_launch_configuration" "lc" {
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  user_data            = "${file(var.user_data_path)}"
  security_groups      = ["${var.security_group_id}"]
  iam_instance_profile = "${var.instance_profile}"

  lifecycle {
    create_before_destroy = true
  }
}
