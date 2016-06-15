output "id" {
  value = "${aws_elb.device.id}"
}

output "name" {
  value = "${aws_elb.device.name}"
}

output "dns_name" {
  value = "${aws_elb.device.dns_name}"
}

output "instances" {
  value = "${aws_elb.device.instances}"
}

output "source_security_group" {
  value = "${aws_elb.device.source_security_group}"
}

output "source_security_group_id" {
  value = "${aws_elb.device.source_security_group_id}"
}

output "zone_id" {
  value = "${aws_elb.device.zone_id}"
}
