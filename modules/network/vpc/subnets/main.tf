module "public_network" {
  source              = "./public"
  project_name_prefix = "${var.project_name_prefix}"
  common_tags         = "${var.common_tags}"
  vpc_id              = "${var.vpc_id}"
  public_subnets      = "${var.public_subnets}"
}

module "app_private_network" {
  source              = "./private"
  project_name_prefix = "${var.project_name_prefix}"
  common_tags         = "${var.common_tags}"
  vpc_id              = "${var.vpc_id}"
  app_private_subnets     = "${var.app_private_subnets}"
}
