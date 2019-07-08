output "public_subnet_ids" {
  description = "Public Subnet ID"
  value = "${module.public_network.public_subnet_id}"
}


output "app_subnet_ids" {
  description = "Private Subnet ID"
  value = "${module.app_private_network.app_subnet_id}"
}


output "private_route_table_ids" {
  description = "Private Route Table IDs"
  value = "${module.app_private_network.route_table_ids}"
}