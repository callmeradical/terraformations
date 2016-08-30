provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "server" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  count                  = "${var.servers}"
  vpc_security_group_ids = ["${aws_security_group.consul.id}"] #Put Split here
  subnet_id              = "${module.vpc.public_1}"

  connection {
    user     = "${var.user}"
    key_file = "${var.key_path_pem}"
  }

  tags {
    Name      = "${var.tagName}-${count.index}"
    Terraform = "true"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/${var.service_conf}"
    destination = "/tmp/${var.service_conf_dest}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${var.servers} > /tmp/consul-server-count",
      "echo ${aws_instance.server.0.private_dns} > /tmp/consul-server-addr",
    ]
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/install_consul_server.sh",
      "${path.module}/scripts/consul_service.sh",
      "${path.module}/scripts/ip_tables.sh",
    ]
  }
}
