variable "type" {}
variable "container_definitions" {}
variable "max_cpu" {}
variable "max_memory" {}

variable "requires_compatibilities" {
  default = "EC2"
}

variable "project_name_prefix" {}

variable "common_tags" {
  type = "map"
}

variable "ecs_task_role_arn" {
  default = ""
}
