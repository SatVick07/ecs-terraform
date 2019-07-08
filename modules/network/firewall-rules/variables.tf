variable "project_name_prefix" {
  description = "Tag with key 'Name' and value will be applied to created resource."
  type = "string"
}
variable "common_tags" {
  description = "Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' "
  type = "map"
  default = {}
}
variable "vpc_cidr" {}
variable "vpc_id" {}
