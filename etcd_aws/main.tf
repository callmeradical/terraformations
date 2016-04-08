provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_security_group" "coreos" {
  name        = "CoreOS security group"
  description = "Allows functionality for CoreOS"

  tags {
    Name      = "CoreOS security group"
    Project   = "${var.project}"
    Terraform = "true"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.ssh_from}"]
  security_group_id = "${aws_security_group.coreos}"
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 4001
  to_port           = 4001
  protocol          = "tcp"
  security_group_id = "${aws_security_group.coreos}"
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 2379
  to_port           = 2379
  protocol          = "tcp"
  security_group_id = "${aws_security_group.coreos}"
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 2380
  to_port           = 2380
  protocol          = "tcp"
  security_group_id = "${aws_security_group.coreos}"
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
  name          = "etcd_config"
  image_id      = "${lookup(var.ami_id, var.aws_region)}"
  instance_type = "t2.medium"
  key_name      = "${var.key_name}"
  user_data     = "${file("${var.user_data}")}"

  lifecycle {
    create_before_destroy = true
  }
}
