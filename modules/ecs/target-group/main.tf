// Backend target group
resource "aws_lb_target_group" "target_group" {
  name                 = "${var.project_name_prefix}-cluster-tg"
  port                 = 80
  protocol             = "HTTP"
  target_type          = "instance"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = "${var.deregistration_delay}"

  health_check {
    protocol            = "HTTP"
    path                = "${var.health_check_path}"
    port                = "traffic-port"
    healthy_threshold   = "${lookup(var.health_check, "healthy_threshold")}"
    unhealthy_threshold = "${lookup(var.health_check, "unhealthy_threshold")}"
    timeout             = "${lookup(var.health_check, "timeout")}"
    interval            = "${lookup(var.health_check, "interval")}"
    matcher             = "${lookup(var.health_check, "http_status")}"
  }

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-tg"
      )
  )}"
}

resource "aws_lb_listener_rule" "https_listener_rule" {
  listener_arn = "${var.https_listener_arn}"
  priority     = "${var.priority}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["${var.path_pattern}"]
  }
}

# resource "aws_alb_listener" "ecs_listener" {
#   load_balancer_arn = "${var.load_balancer_arn}"
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     target_group_arn = "${aws_lb_target_group.target_group.arn}"
#     type             = "forward"
#   }
# }