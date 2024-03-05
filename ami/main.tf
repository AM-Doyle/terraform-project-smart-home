

resource "aws_ami_from_instance" "heating_ami" {
  name               = "tp_heating_ami"
  source_instance_id = "i-0bfba84d169b6ba72"
}
resource "aws_ami_from_instance" "lights_ami" {
  name               = "tp_lights_ami"
  source_instance_id = "i-07e8864a6ecf4d7e0"
}
resource "aws_ami_from_instance" "status_ami" {
  name               = "tp_status_ami"
  source_instance_id = "i-0dd6403ebf2a72a45"
}
resource "aws_ami_from_instance" "auth_ami" {
  name               = "tp_auth_ami"
  source_instance_id = "i-01d8831c6e904503e"
}
