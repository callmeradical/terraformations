provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_security_group" "coreos" {
  name        = "CoreOS security group"
  description = "Allows functionality for CoreOS"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["${var.ssh_from}"]
  }

  ingress {
    from_port   = 4001
    to_port     = 4001
    protocol    = "TCP"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 2379
    to_port     = 2379
    protocol    = "TCP"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 2380
    to_port     = 2380
    protocol    = "TCP"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "CoreOS security group"
    Project   = "${var.project}"
    Terraform = "true"
  }
}

resource "aws_autoscaling_group" "etcd" {
  vpc_zone_identifier  = ["${var.subnet_1}", "${var.subnet_2}"]
  name                 = "etcd"
  max_size             = 5
  min_size             = 3
  desired_capacity     = 3
  launch_configuration = "${aws_launch_configuration.etcd.name}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "etcd"
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

resource "aws_launch_configuration" "etcd" {
  name            = "etcd_config"
  image_id        = "${lookup(var.ami_id, var.aws_region)}"
  instance_type   = "t2.medium"
  key_name        = "${var.key_name}"
  user_data       = "${file(var.user_data)}"
  security_groups = ["${aws_security_group.coreos.id}"]
  iam_instance_profile = "${var.readonly_instance_profile}"
  lifecycle {
    create_before_destroy = true
  }
}
