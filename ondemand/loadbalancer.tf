module "create_alb" {
  source   = "./../modules/alb"
  alb_name = "${var.alb_name}"

  # ssl_policy = "${var.ssl_policy}"
  # certificate_arn = "${var.certificate_arn}"
  project_name_prefix = "${local.project_name_prefix}"

  alb_internet_accessbility = "${var.alb_internet_accessbility}"
  deletion_protection       = "${var.deletion_protection}"
  alb_load_balancer_type    = "${var.alb_load_balancer_type}"
  vpc_id                    = "${data.terraform_remote_state.static.vpc_id}"
  custom-subnets            = ["${data.terraform_remote_state.static.public_subnets}"]

  # iam_role = ""
  source_cidr = "${data.terraform_remote_state.static.source_cidr}"
  common_tags = "${local.common_tags}"
  alb_sg_id   = "${data.terraform_remote_state.static.alb_sg_id}"
}
