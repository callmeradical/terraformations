output "launch_config_id" {
  value = "${aws_launch_configuration.lc.id}"
}

output "id" {
  value = "${aws_autoscaling_group.asg.id}"
}

output "availability_zones" {
  value = "${aws_autoscaling_group.asg.availability_zones}"
}

output "min_size" {
  value = "${aws_autoscaling_group.asg.min_size}"
}

output "max_size" {
  value = "${aws_autoscaling_group.asg.max_size}"
}

output "default_cooldown" {
  value = "${aws_autoscaling_group.asg.default_cooldown}"
}

output "name" {
  value = "${aws_autoscaling_group.asg.name}"
}

output "health_check_grace_period" {
  value = "${aws_autoscaling_group.asg.health_check_grace_period}"
}

output "health_check_type" {
  value = "${aws_autoscaling_group.asg.health_check_type}"
}

output "desired_capacity" {
  value = "${aws_autoscaling_group.asg.desired_capacity}"
}

output "launch_configuration" {
  value = "${aws_autoscaling_group.asg.launch_configuration}"
}

output "vpc_zone_identifier" {
  value = "${aws_autoscaling_group.asg.vpc_zone_identifier}"
}

output "load_balancers" {
  value = "${aws_autoscaling_group.asg.load_balancers}"
}
