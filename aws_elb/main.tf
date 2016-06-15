resource "aws_elb" "device" {
  name            = "${var.elb_name}"
  subnets         = ["${var.subnet1}", "${var.subnet2}"]
  security_groups = ["${var.security_group}"]

  access_logs {
    bucket        = "${var.s3_log_bucket}"
    bucket_prefix = "${var.elb_name}"
    interval      = 60
  }

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.lb_protocol}"
  }

  listener {
    instance_port      = "${var.instance_port}"
    instance_protocol  = "${var.instance_protocol}"
    lb_port            = "${var.lb_port}"
    lb_protocol        = "${var.lb_protocol}"
    ssl_certificate_id = "${var.certificate_arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.target}"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Terraform = "true"
    Name      = "${var.elb_name}"
    Service   = "${var.service_name}"
  }
}
