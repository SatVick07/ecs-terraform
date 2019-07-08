variable "project_name_prefix" {}

variable "common_tags" {
  type = "map"
}

variable "vpc_id" {}

variable "deregistration_delay" {
  default = 30
}

variable "health_check_path" {}

variable "health_check" {
  type = "map"
}

variable "https_listener_arn" {}

variable "load_balancer_arn" {

}

variable "path_pattern" {}
variable "type" {}
variable "priority" {}
