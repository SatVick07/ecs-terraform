resource "aws_ecs_service" "service" {
  name                               = "${var.project_name_prefix}-${var.type}"
  cluster                            = "${var.ecs_cluster_id}"
  task_definition                    = "${var.ecs_task_arn}"
  desired_count                      = "${var.ecs_task_desired_count}"
  # iam_role                           = "${var.ecs_service_role_arn}"
  launch_type                        = "EC2"
  scheduling_strategy                = "REPLICA"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"
  health_check_grace_period_seconds  = "${var.health_check_grace_period_seconds}"
  # enable_ecs_managed_tags            = true

  load_balancer {
    target_group_arn = "${var.ecs_target_group_arn}"
    container_name   = "${var.exposed_ecs_container_name}"
    container_port   = "${var.exposed_ecs_container_port}"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:stack_type == app"
  }

  tags = "${merge(
    var.common_tags,
      map(
      "Name" ,"${var.project_name_prefix}-${var.type}"
        )
    )}"

  lifecycle {
    ignore_changes = ["desired_count"]
  }
}
