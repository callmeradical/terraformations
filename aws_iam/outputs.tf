output "role_id" {
  value = "${aws_iam_role.role.unique_id}"
}

output "role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "policy_arn" {
  value = "${aws_iam_policy.policy.arn}"
}

output "policy_name" {
  value = "${aws_iam_policy.policy.name}"
}

output "policy" {
  value = "${aws_iam_policy.policy.policy}"
}

output "policy_id" {
  value = "${aws_iam_policy.policy.id}"
}

output "instance_profile_id" {
  value = "${aws_iam_instance_profile.profile.id}"
}

output "instance_profile_arn" {
  value = "${aws_iam_instance_profile.profile.arn}"
}

output "instance_profile_create_date" {
  value = "${aws_iam_instance_profile.profile.create_date}"
}

output "instance_profile_roles" {
  value = "${aws_iam_instance_profile.profile.roles}"
}

output "instance_profile_unique_id" {
  value = "${aws_iam_instance_profile.profile.unique_id}"
}

output "depends_id" {
  value = "${null_resource.dummy.id}"
}
