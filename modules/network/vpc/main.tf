// Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}"
      )
  )}"
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.main.default_network_acl_id}"

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-default-network-acl"
      )
  )}"

  lifecycle {
    ignore_changes = ["subnet_ids"]
  }
}
module "subnets" {
  source              = "./subnets/"
  project_name_prefix = "${var.project_name_prefix}"
  common_tags         = "${var.common_tags}"
  vpc_id              = "${aws_vpc.main.id}"
  public_subnets      = "${var.public_subnets}"
  app_private_subnets = "${var.app_private_subnets}"
}

resource "aws_eip" "nat_gateway_eip" {
  # count = "${local.nat_gateway_count * var.create_nat_gateway_eip}"
  # vpc   = true

  tags = "${merge(
    var.common_tags,
    map(
      "Name" ,"${var.project_name_prefix}"
      )
  )}"
}
module "nat_gateway" {
  source                      = "./nat-gateway/"
  project_name_prefix         = "${var.project_name_prefix}"
  common_tags                 = "${var.common_tags}"
  public_subnet_ids           = "${module.subnets.public_subnet_ids}"
  nat_gateways_allocation_ids = "${aws_eip.nat_gateway_eip.*.id}"
  associate_route_table_ids   = "${module.subnets.private_route_table_ids}"
  # nat_gateway_count           = "${local.nat_gateway_count}"
  # subnet_association_count    = "${local.subnet_association_count}"
}
