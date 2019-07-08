resource "aws_iam_role" "role" {
  name = "${var.name}-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
   }
  EOF

  tags = "${merge(
    var.common_tags,
    map(
     "Name" ,"${var.name}-role"
      )
  )}"
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.name}-profile"
  role = "${aws_iam_role.role.name}"
}
