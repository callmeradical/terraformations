output "vpc" {
  value = "${aws_vpc.default.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.default.cidr_block}"
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

output "public_2" {
  value = "${aws_subnet.public_b.id}"
}
