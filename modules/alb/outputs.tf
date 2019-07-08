
output "alb_arn" {
  description = "Application Load Balancer ARN"
  value = "${aws_alb.create_alb.arn}"
}

# output "listener-arn-443" {
#   description = "Listener ARN on Port 443"
#   value = "${aws_alb_listener.create_listner_443.arn}"
# }

output "listener-arn-80" {
  description = "Listener ARN on Port 80"
  value = "${aws_alb_listener.create_listener_80.arn}"
}

output "target_group_arn" {
  value = "${aws_lb_target_group.default_HTTP_target_group.arn}"
}

output "alb_dns" {
  description = "DNS Name"
  value = "${aws_alb.create_alb.dns_name}"
}


