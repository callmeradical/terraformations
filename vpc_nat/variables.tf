variable "aws_region" {
  description = "Desired region to build infra."
}

variable "default_vpc_cidr" {
  description = "The CIDR for the default vpc"
}

variable "public_a_subnet" {
  description = "The CIDR for the public subnet in AZ A"
}

variable "public_b_subnet" {
  description = "The CIDR for the public subnet in AZ B"
}

variable "private_a_subnet" {
  description = "The CIDR for the private subnet in AZ A"
}

variable "private_b_subnet" {
  description = "The CIDR for the private subnet in AZ B"
}

variable "vpc_name" {
  description = "The Name of My VPC"
}

variable "az1" {}

variable "az2" {}
