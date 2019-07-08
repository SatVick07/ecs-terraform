
module "iam" {
  source      = "../modules/roles/instance_profile"
  name        = "${local.project_name_prefix}"
  common_tags = "${local.common_tags}"
}
data "template_file" "ecs_template" {
  template = "${file("${path.module}/iam-policy/ecs-instance-iam.tpl")}"
}

resource "aws_iam_policy" "ecs_policy" {
  name        = "${local.project_name_prefix}-common-ecs-policy"
  description = "Policy for ECS access"
  policy      = "${data.template_file.ecs_template.rendered}"
}

resource "aws_iam_role_policy_attachment" "ecs_policy_attach" {
  role       = "${module.iam.aws_iam_instance_role_name}"
  policy_arn = "${aws_iam_policy.ecs_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = "${module.iam.aws_iam_instance_role_name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

data "template_file" "ecs_service_principal_template" {
  template = "${file("${path.module}/iam-policy/ecs-service-principal.tpl")}"
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "${local.project_name_prefix}-ecs-service-role"
  assume_role_policy = "${data.template_file.ecs_service_principal_template.rendered}"

  tags = "${merge(
    local.common_tags,
    map(
     "Name" ,"${local.project_name_prefix}-ecs-service-role"
      )
  )}"
}

data "template_file" "ecs_service_access_template" {
  template = "${file("${path.module}/iam-policy/ecs-service-access.tpl")}"
}

resource "aws_iam_policy" "ecs_service_policy" {
  name        = "${local.project_name_prefix}-common-ecs-service-policy"
  description = "Policy for ECS Service access"
  policy      = "${data.template_file.ecs_service_access_template.rendered}"
}

resource "aws_iam_role_policy_attachment" "ecs_service_policy_attach" {
  role       = "${aws_iam_role.ecs_service_role.name}"
  policy_arn = "${aws_iam_policy.ecs_service_policy.arn}"
}
