output "vpc_id" {
  value = "${module.create_vpc.vpc_id}"
}

output "public_subnets" {
  value = "${module.create_vpc.public_subnet_ids}"
}
output "private_subnets" {
  value = "${module.create_vpc.app_subnet_ids}"
}

output "source_cidr" {
  value = "${module.create_vpc.vpc_cidr}"
}

output "common_tags" {
  value = "${local.common_tags}"
}

output "project_name_prefix" {
  value = "${local.project_name_prefix}"
}

output "alb_sg_id" {
  value = "${module.firewall_rules.alb_sg_id}"
}
