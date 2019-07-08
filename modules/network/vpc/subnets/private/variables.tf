variable "project_name_prefix" {
  description = "Tag with key 'Name' and value will be applied to created resource."
  type = "string"
}
variable "common_tags" {
  description = "Custom tags in the form of map can be passed, use keys apart from 'Project' and 'Name' "
  type = "map"
  default = {}
}
variable "vpc_id" {}
variable "app_private_subnets" {
  description = "Private Subnet List of map with respective AZ and CIDR"
  type = "list"
}