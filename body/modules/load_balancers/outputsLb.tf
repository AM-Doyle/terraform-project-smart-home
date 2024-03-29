output "dns_name" {
  value = aws_lb.tp_public_load_balancer.dns_name
}
output "private_dns_name" {
  value = aws_lb.tp_private_load_balancer.dns_name
}
output "target_group_arns" {
  value = aws_lb_target_group.tp-tgs[*].arn
}