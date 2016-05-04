output "launch_config_id" {
  value = "${aws_launch_configuration.lc.id}"
}

output "id" {
  description = "The autoscaling group name."
  value       = "${aws_autoscaling_group.asg.id}"
}

output "availability_zones" {
  description = "The availability zones of the autoscale group."
  value       = "${aws_autoscaling_group.asg.availability_zones}"
}

output "min_size" {
  description = "The minimum size of the autoscale group"
  value       = "${aws_autoscaling_group.asg.min_size}"
}

output "max_size" {
  description = "The maximum size of the autoscale group"
  value       = "${aws_autoscaling_group.asg.max_size}"
}

output "default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity."
  value       = "${aws_autoscaling_group.asg.default_cooldown}"
}

output "name" {
  description = "The name of the autoscale group"
  value       = "${aws_autoscaling_group.asg.name}"
}

output "health_check_grace_period" {
  description = "Time after instance comes into service before checking health."
  value       = "${aws_autoscaling_group.asg.health_check_grace_period}"
}

output "health_check_type" {
  description = "Controls how health checking is done."
  value       = "${aws_autoscaling_group.asg.health_check_type}"
}

output "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  value       = "${aws_autoscaling_group.asg.desired_capacity}"
}

output "launch_configuration" {
  description = "The launch configuration of the autoscale group"
  value       = "${aws_autoscaling_group.asg.launch_configuration}"
}

output "vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = "${aws_autoscaling_group.asg.vpc_zone_identifier}"
}

output "load_balancers" {
  description = "The load balancer names associated with the autoscaling group."
  value       = "${aws_autoscaling_group.asg.load_balancers}"
}
