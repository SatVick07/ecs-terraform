# output "nat_sg_id" {
#   value = "${aws_security_group.nat.*.id}"
# }

output "app_sg_id" {
  value = "${aws_security_group.app_sg.id}"
}

output "alb_sg_id" {
  value = "${aws_security_group.public.id}"
}
