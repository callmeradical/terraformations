variable "elb_name" {
  description = "The name of the Load Balancer"
}

variable "subnet1" {}

variable "subnet2" {}

variable "security_group" {}

variable "s3_log_bucket" {
  description = "The Name of the bucket to capture load balancer logs."
}

variable "instance_port" {
  description = "The number of the port on the instance to connect to."
}

variable "lb_port" {
  description = "The number of the port on the load balancer to expose"
}

variable "instance_protocol" {
  description = "The protocol to use on the instance"
}

variable "lb_protocol" {
  description = "The protocol to use on the load balancer"
}

variable "certificate_arn" {}

variable "target" {
  description = "The Health Check target for the ELB"
}

variable "service_name" {}
