output "vpc" {
  value = "${aws_vpc.default.id}"
}

output "subnet_1" {
  value = "${aws_subnet.private_a.id}"
}

output "subnet_2" {
  value = "${aws_subnet.private_b.id}"
}

output "public_1" {
  value = "${aws_subnet.public_a.id}"
}
