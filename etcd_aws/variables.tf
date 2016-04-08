variable "aws_region" {
  description = "Desired region to build infra."
  default     = "us-east-1"
}

variable "ami_id" {
  description = "valid CoreOS ami for regions"
  type        = "map"

  default = {
    us-east-1 = "ami-7a627510"
    us-west-1 = "ami-d8770bb8"
  }
}

variable "ssh_from" {
  description = "allow ssh access from this cidr block"
}

variable "subnet_1" {
  description = "first subnet for vpc_zone_identifier"
}

variable "subnet_2" {
  description = "first subnet for vpc_zone_identifier"
}

variable "user_data" {
  description = "cloud config to launch etcd cluster"
}

variable "project" {
  description = "The name of the project this is associated with"
}

variable "key_name" {}

variable "vpc_id" {}
