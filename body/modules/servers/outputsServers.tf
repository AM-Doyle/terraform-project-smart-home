output "public_ec2_ids" {
  value = aws_instance.public_ec2s[*].id
}
output "private_ec2_ids" {
  value = aws_instance.private_ec2s[*].id
}