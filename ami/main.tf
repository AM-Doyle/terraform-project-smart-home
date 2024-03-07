

resource "aws_ami_from_instance" "heating_ami" {
  name               = "tp_heating_ami"
  source_instance_id = "i-09e55d8fc15a2ed9e"
}
resource "aws_ami_from_instance" "lights_ami" {
  name               = "tp_lights_ami"
  source_instance_id = "i-0eb823000b3f5ce7b"
}
resource "aws_ami_from_instance" "status_ami" {
  name               = "tp_status_ami"
  source_instance_id = "i-060ff282b97302a15"
}
resource "aws_ami_from_instance" "auth_ami" {
  name               = "tp_auth_ami"
  source_instance_id = "i-0773a4c89606cf12e"
}
