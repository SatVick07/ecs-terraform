# Launch configuration
output "launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = "${aws_launch_configuration.this.id}"
}

output "launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = "${aws_launch_configuration.this.name}"
}

# Autoscaling group
output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = "${aws_autoscaling_group.this.id}"
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = "${aws_autoscaling_group.this.name}"
}

output "autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = "${aws_autoscaling_group.this.arn}"
}


output "autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = "${element(concat(aws_autoscaling_group.this.vpc_zone_identifier, list("")), 0)}"
}


output "autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = "${aws_autoscaling_group.this.target_group_arns}"
}
