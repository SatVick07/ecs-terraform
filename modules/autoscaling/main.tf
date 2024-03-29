#######################
# Launch configuration
#######################
data "null_data_source" "tags" {
  count = "${length(keys(var.common_tags))}"

  inputs = {
    key                 = "${element(keys(var.common_tags), count.index)}"
    value               = "${element(values(var.common_tags), count.index)}"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "this" {
  name                        = "${var.name}-lc"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  ebs_optimized               = "${var.ebs_optimized}"
  enable_monitoring           = "${var.enable_monitoring}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"

  # key_name                    = "${var.key_name}"
  security_groups = ["${var.security_groups}"]
  user_data       = "${var.user_data}"

  # dynamic "ebs_block_device" {
  #   for_each = "${var.ebs_block_device}"


  #   content {
  #     delete_on_termination = "${lookup(ebs_block_device.value, "delete_on_termination", null)}"
  #     device_name           = "${ebs_block_device.value.device_name}"
  #     encrypted             = "${lookup(ebs_block_device.value, "encrypted", null)}"
  #     iops                  = "${lookup(ebs_block_device.value, "iops", null)}"
  #     no_device             = "${lookup(ebs_block_device.value, "no_device", null)}"
  #     snapshot_id           = "${lookup(ebs_block_device.value, "snapshot_id", null)}"
  #     volume_size           = "${lookup(ebs_block_device.value, "volume_size", null)}"
  #     volume_type           = "${lookup(ebs_block_device.value, "volume_type", null)}"
  #   }
  # }


  # dynamic "ephemeral_block_device" {
  #   for_each = "${var.ephemeral_block_device}"


  #   content {
  #     device_name  = "${ephemeral_block_device.value.device_name}"
  #     virtual_name = "${ephemeral_block_device.value.virtual_name}"
  #   }
  # }


  # dynamic "root_block_device" {
  #   for_each = "${var.root_block_device}"


  #   content {
  #     delete_on_termination = "${lookup(root_block_device.value, "delete_on_termination", null)}"
  #     iops                  = "${lookup(root_block_device.value, "iops", null)}"
  #     volume_size           = "${lookup(root_block_device.value, "volume_size", null)}"
  #     volume_type           = "${lookup(root_block_device.value, "volume_type", null)}"
  #   }
  # }

  lifecycle {
    create_before_destroy = true
  }
}

/*
# Attempt at improving the issue where it cannot delete the old LC on changes
resource "null_resource" "delay" {
  # count = 10
  depends_on = [
    "aws_launch_configuration.this"
  ]
  triggers {
    delay = "${aws_launch_configuration.this.name}"
  }
  lifecycle {
    create_before_destroy = true
  }
}
*/

####################
# Autoscaling group
####################
resource "aws_autoscaling_group" "this" {
  #depends_on = [
  #  "null_resource.delay"
  #]
  name = "${var.name}-asg"

  launch_configuration = "${aws_launch_configuration.this.name}"
  vpc_zone_identifier  = ["${var.vpc_zone_identifier}"]

  #   launch_configuration = "${var.launch_configuration == "" ? element(concvpc_zone_identifier  = "${var.vpc_zone_identifier}"at(aws_launch_configuration.this.*.name, list("")), 0) : var.launch_configuration}"
  #   vpc_zone_identifier  = "${var.vpc_zone_identifier}"
  max_size = "${var.max_size}"

  min_size         = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"

  load_balancers            = "${var.load_balancers}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  #availability_zones   = ["${var.availability_zones}"]
  default_cooldown    = "${var.default_cooldown}"
  enabled_metrics     = "${var.enabled_metrics}"
  force_delete        = "${var.force_delete}"
  metrics_granularity = "${var.metrics_granularity}"
  min_elb_capacity    = "${var.min_elb_capacity}"

  #   placement_group       = "${var.placement_group}"
  protect_from_scale_in = "${var.protect_from_scale_in}"
  suspended_processes   = "${var.suspended_processes}"
  # target_group_arns     = ["${var.target_group_arns}"]
  termination_policies  = "${var.termination_policies}"
  tags                  = ["${data.null_data_source.tags.*.outputs}"]

  tags = [
    {
      key                 = "Name"
      value               = "${var.name}-asg"
      propagate_at_launch = true
    },
  ]

  lifecycle {
    create_before_destroy = true
  }
}
