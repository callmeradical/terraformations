variable "aws_region" {
  description = "Desired region to build infra."
  default = "us-east-1"
}

variable "default_vpc_cidr" {
  description = "The CIDR for the default vpc"
  default = "10.88.0.0/16"
}

variable "public_a_subnet" {
  description = "The CIDR for the public subnet in AZ A"
  default = "10.88.1.0/24"
}

variable "public_b_subnet" {
  description = "The CIDR for the public subnet in AZ B"
  default = "10.88.3.0/24"
}

variable "private_a_subnet" {
  description = "The CIDR for the private subnet in AZ A"
  default = "10.88.2.0/24"
}

variable "private_b_subnet" {
  description = "The CIDR for the private subnet in AZ B"
  default = "10.88.4.0/24"
}
