
output "heating_ami" {
  value = aws_ami_from_instance.heating_ami.id
}
output "lights_ami" {
  value = aws_ami_from_instance.lights_ami.id
}
output "status_ami" {
  value = aws_ami_from_instance.status_ami.id
}
output "auth_ami" {
  value = aws_ami_from_instance.auth_ami.id
}