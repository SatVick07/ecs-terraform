resource "aws_ecs_task_definition" "task" {
  family                   = "${var.project_name_prefix}-${var.type}"
  network_mode             = "bridge"
  # task_role_arn            = "${var.ecs_task_role_arn}"
  cpu                      = "${var.max_cpu}"
  memory                   = "${var.max_memory}"
  requires_compatibilities = ["${var.requires_compatibilities}"]
  container_definitions    = "${var.container_definitions}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-${var.type}"
      )
  )}"
}