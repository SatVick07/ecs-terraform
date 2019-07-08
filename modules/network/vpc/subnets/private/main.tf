resource "aws_subnet" "app_private_subnets" {
  count             = "${length(var.app_private_subnets)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${lookup(var.app_private_subnets[count.index], "cidr")}"
  availability_zone = "${lookup(var.app_private_subnets[count.index], "az")}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-private-${count.index + 1}"
      )
  )}"
}

resource "aws_route_table" "app_private_route_tables" {
  vpc_id = "${var.vpc_id}"

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.project_name_prefix}-private"
      )
  )}"
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = "${length(var.app_private_subnets)}"
  subnet_id      = "${element(aws_subnet.app_private_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.app_private_route_tables.*.id, count.index)}"
}

