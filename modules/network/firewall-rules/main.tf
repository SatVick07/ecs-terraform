#--------------------------------------------------------------
# SG rules
#--------------------------------------------------------------

resource "aws_security_group" "app_sg" {
  name        = "${var.project_name_prefix}-app-sg"
  vpc_id      = "${var.vpc_id}"
  description = "App security group"

  ingress {
    protocol        = "tcp"
    from_port       = 32768
    to_port         = 65535
    security_groups = ["${aws_security_group.public.id}"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-app-sg"
      )
  )}"
}

resource "aws_security_group" "public" {
  name        = "${var.project_name_prefix}-public"
  vpc_id      = "${var.vpc_id}"
  description = "Public Security Group"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-public"
      )
  )}"

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "nat" {
#   # count       = "${var.launch_nat_gateway}"
#   name        = "${var.project_name_prefix}-nat"
#   vpc_id      = "${var.vpc_id}"
#   description = "NAT security group"


#   tags = "${merge(
#     var.common_tags,
#     map(
#      "Name" ,"${var.project_name_prefix}-nat"
#       )
#   )}"


#   ingress {
#     protocol    = "tcp"
#     from_port   = 22
#     to_port     = 22
#     cidr_blocks = ["${var.vpc_cidr}"]
#   }


#   ingress {
#     protocol    = "tcp"
#     from_port   = 80
#     to_port     = 80
#     cidr_blocks = ["${var.vpc_cidr}"]
#   }


#   ingress {
#     protocol    = "tcp"
#     from_port   = 443
#     to_port     = 443
#     cidr_blocks = ["${var.vpc_cidr}"]
#   }


#   egress {
#     protocol    = -1
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

