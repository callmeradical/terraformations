output "public_ip" {
  value = "${aws_instance.bastion_box.public_ip}"
}
