output "alb_arn" {
  description = "Application Load Balancer ARN"
  value = "${module.create_alb.alb_arn}"
}

# output "listener-arn-443" {
#   description = "Listener ARN on Port 443"
#   value = "${aws_alb_listener.create_listner_443.arn}"
# }

output "listener-arn-80" {
  description = "Listener ARN on Port 80"
  value = "${module.create_alb.listener-arn-80}"
}

output "alb_dns" {
  description = "DNS Name"
  value = "${module.create_alb.alb_dns}"
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value = "${module.cluster.ecs_cluster_id}"
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value = "${module.cluster.ecs_cluster_name}"
}
output "ecs_target_group_arn" {
  value = "${module.target-group.ecs_target_group_arn}"
}
output "target_group_arn" {
  value = "${module.create_alb.target_group_arn}"
}

