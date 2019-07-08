resource "aws_ecs_cluster" "this" {
  name = "${var.cluster_name}"
  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.cluster_name}"
      )
  )}"
}