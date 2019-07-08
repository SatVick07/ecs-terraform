variable "alb_name" {
  default = "kms-uat-alb"
}

variable "ecs_service_role" {
  default = "ecsServiceRole"
}

variable "task_max_cpu" {
  default = 512
  description = "Max CPU alloted to task"
}
variable "task_max_memory" {
  default = 512
  description = "Max memory alloted to task"
}
# variable "project_name_prefix" {
#   description = "Tag with key 'Name' and value will be applied to created resource."
#   type        = "string"
# }

# variable "common_tags" {
#   description = "Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' "
#   type        = "map"
#   default     = {}
# }

# variable "vpc_cidr" {}

# variable "public_subnets" {
#   description = "Public Subnet List of map with respective AZ and CIDR"
#   type        = "list"
# }

variable "alb_internet_accessbility" {
  default = "false"
}

variable "deletion_protection" {
  default = "false"
}

variable "alb_load_balancer_type" {
  default = "application"
}
variable "task_type_name" {
  default = "kms"
}

variable "health_check_grace_period_seconds" {
  default = 160
}
variable "exposed_ecs_container_name" {
  default = "web_app"
}
variable "exposed_ecs_container_port" {
  default = 80
}
variable "deployment_minimum_healthy_percent" {
  default = 100
}
variable "deployment_maximum_percent" {
  default = 200
}

variable "priority" {
  default = 3
}
variable "path_pattern" {
  default = "/"
}

variable "health_check_path" {
  default = "/"
}

variable "https_health_check" {
  type = "map"

  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 20
    interval            = 40
    http_status         = 200
  }
}