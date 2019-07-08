output "aws_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "aws_iam_instance_role_name" {
  value = "${aws_iam_role.role.name}"
}

output "aws_iam_instance_role_arn" {
  value = "${aws_iam_role.role.arn}"
}
