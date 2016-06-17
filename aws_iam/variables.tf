variable "aws_region" {
  description = "Desired region to build infra."
}

variable "profile_name" {
  description = "The name of the IAM profile to create"
}

variable "role_name" {
  description = "The name of the role to create"
}

variable "policy_name" {
  description = "The name of the policy to create"
}

variable "policy_path" {
  description = "The path to an IAM policy doc in JSON format"
}

variable "depends_id" {}
