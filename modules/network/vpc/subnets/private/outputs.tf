output "app_subnet_id" {
  value = "${aws_subnet.app_private_subnets.*.id}"
}
output "route_table_ids" {
  description = "Route Table IDs"
  value = "${aws_route_table.app_private_route_tables.*.id}"
}
