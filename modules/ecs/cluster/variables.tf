
variable "cluster_name" {
  description = "ECS cluster name"
  default = "default_ecs_cluster"
}

variable "common_tags" {
  description = "Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' "
  type = "map"
  default = {}
}

