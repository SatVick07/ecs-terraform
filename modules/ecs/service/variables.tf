variable "type" {}

variable "project_name_prefix" {}

variable "common_tags" {
  type = "map"
}

variable "ecs_task_desired_count" {
  default = 1
}

variable "ecs_cluster_id" {}
variable "ecs_task_arn" {}
variable "health_check_grace_period_seconds" {}
variable "ecs_target_group_arn" {}
variable "exposed_ecs_container_name" {}
variable "exposed_ecs_container_port" {}
# variable "ecs_service_role_arn" {}
variable "deployment_minimum_healthy_percent" {}
variable "deployment_maximum_percent" {}
