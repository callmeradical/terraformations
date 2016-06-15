provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_launch_configuration" "lc" {
  name                 = "${var.name}-config"
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

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier  = ["${var.subnet_1}", "${var.subnet_2}"]
  name                 = "${var.name}-asg"
  max_size             = 5
  min_size             = 3
  desired_capacity     = 3
  launch_configuration = "${aws_launch_configuration.lc.name}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "${var.project}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
}
