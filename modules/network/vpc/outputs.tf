output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
output "vpc_cidr" {
  value = "${aws_vpc.main.cidr_block}"
}
output "public_subnet_ids" {
  description = "Public Subnet ID"
  value = "${module.subnets.public_subnet_ids}"
}

output "app_subnet_ids" {
  description = "Private Subnet ID"
  value = "${module.subnets.app_subnet_ids}"
}

output "nat_gateways_allocation_ids" {
  description = "NAT Gateway Allocation IDs"
  value = "${aws_eip.nat_gateway_eip.*.id}"
}

output "nat_gateways_public_ips" {
  description = "NAT Gateways Public IP"
  value = "${aws_eip.nat_gateway_eip.*.public_ip}"
}


