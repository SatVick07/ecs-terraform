module "cluster" {
  source       = "../modules/ecs/cluster"
  cluster_name = "kms-uat-cluster"
  common_tags  = "${local.common_tags}"
}

module "task" {
  source                = "../modules/ecs/task-definition"
  type                  = "${var.task_type_name}"
  container_definitions = "${file("${path.module}/ecs-files/container_definitions.json")}"
  max_cpu               = "${var.task_max_cpu}"
  max_memory            = "${var.task_max_memory}"
  project_name_prefix   = "${local.project_name_prefix}"
  common_tags           = "${local.common_tags}"
  ecs_task_role_arn     = "${aws_iam_role.ecs_service_role.arn}"
}

module "target-group" {
  source              = "../modules/ecs/target-group"
  type                = "${var.task_type_name}"
  project_name_prefix = "${local.project_name_prefix}"
  common_tags         = "${local.common_tags}"
  vpc_id              = "${data.terraform_remote_state.static.vpc_id}"
  health_check_path   = "${var.health_check_path}"
  health_check        = "${var.https_health_check}"
  path_pattern        = "${var.path_pattern}"
  https_listener_arn  = "${module.create_alb.listener-arn-80}"
  priority            = "${var.priority}"
  load_balancer_arn   = "${module.create_alb.alb_arn}"
}

module "service" {
  source                            = "../modules/ecs/service"
  type                              = "${var.task_type_name}"
  project_name_prefix               = "${local.project_name_prefix}"
  common_tags                       = "${local.common_tags}"
  ecs_cluster_id                    = "${module.cluster.ecs_cluster_id}"
  ecs_task_arn                      = "${module.task.task_arn}"
  health_check_grace_period_seconds = "${var.health_check_grace_period_seconds}"
  ecs_target_group_arn              = "${module.target-group.ecs_target_group_arn}"

  # ecs_service_role_arn               = "${aws_iam_role.ecs_service_role.arn}"
  # ecs_service_role              = "${var.ecs_service_role}"
  exposed_ecs_container_name         = "${var.exposed_ecs_container_name}"
  exposed_ecs_container_port         = "${var.exposed_ecs_container_port}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
}
