data "template_file" "user_data" {
  template = "${file("${path.module}/ecs-files/user_data.sh.tpl")}"

  vars = {
    ecs_cluster_name = "${module.cluster.ecs_cluster_name}"
  }
}

module "ecs_asg" {
  source               = "./../modules/autoscaling"
  name                 = "${module.cluster.ecs_cluster_name}"
  image_id             = "ami-05af3f57a0b59fb78"
  instance_type        = "t2.micro"
  iam_instance_profile = "${module.iam.aws_iam_instance_profile_name}"
  security_groups      = ["${data.terraform_remote_state.static.alb_sg_id}"]
  user_data            = "${data.template_file.user_data.rendered}"
  common_tags          = "${local.common_tags}"
  vpc_zone_identifier = "${join(",",data.terraform_remote_state.static.private_subnets)}"
  # target_group_arns    = ["${module.create_alb.target_group_arn}"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  #Auto-Scaling Group
  #   vpc_zone_identifier       = [
  #   "subnet-0ef86b89a29ffa4a7",
  #   "subnet-0f69658090d2a2570",
  #   "subnet-01972f49020b43e2b",
  # ]
  #   vpc_zone_identifier = "${module.create_vpc.app_subnet_ids}"
  health_check_type = "EC2"

  min_size                = 0
  max_size                = 1
  desired_capacity        = 1
  enable_scaling_policies = true
}
