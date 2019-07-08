output "ecs_target_group_arn" {
  value = "${aws_lb_target_group.target_group.arn}"
}
# output "ecs_listener_arn" {
#   value = "${aws_alb_listener.ecs_listener.arn}"
# }
