resource "aws_alb" "create_alb" {
  name               = "${var.alb_name}"
  internal           = "${var.alb_internet_accessbility}"
  idle_timeout       = "300"
  load_balancer_type = "${var.alb_load_balancer_type}"

  security_groups = [
    "${var.alb_sg_id}",
  ]

  subnets                    = ["${var.custom-subnets}"]
  enable_deletion_protection = "${var.deletion_protection}"
  tags                       = "${merge(var.common_tags,map("Name" ,"${var.alb_name}"))}"
}

resource "aws_lb_target_group" "default_HTTP_target_group" {
  name        = "${var.project_name_prefix}-df-HTTP"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-df-HTTP"
      )
  )}"
}

resource "aws_alb_listener" "create_listener_80" {
  load_balancer_arn = "${aws_alb.create_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.default_HTTP_target_group.arn}"
    type             = "forward"
  }
}

# resource "aws_lb_target_group" "default_HTTPS_target_group" {
#   name        = "${var.project_name_prefix}-df-HTTPS"
#   port        = 443
#   protocol    = "HTTPS"
#   target_type = "instance"
#   vpc_id      = "${var.vpc_id}"


#   tags = "${merge(
#     var.common_tags,
#     map(
#      "Name" ,"${var.project_name_prefix}-df-HTTPS"
#       )
#   )}"
# }
# resource "aws_alb_listener" "create_listner_443" {
#   load_balancer_arn = "${aws_alb.create_alb.arn}"
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "${var.ssl_policy}"
#   certificate_arn   = "${var.certificate_arn}"


#   default_action {
#    type = "fixed-response"
#     fixed_response {
#       content_type = "application/json"
#       message_body = "SORRY"
#       status_code = "506"
#     }
#  }
# }

