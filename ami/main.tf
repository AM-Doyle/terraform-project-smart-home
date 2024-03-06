

resource "aws_ami_from_instance" "heating_ami" {
  name               = "tp_heating_ami"
  source_instance_id = "i-0ccbe545567c3d569"
}
resource "aws_ami_from_instance" "lights_ami" {
  name               = "tp_lights_ami"
  source_instance_id = "i-01bd503afc2bf4eb4"
}
resource "aws_ami_from_instance" "status_ami" {
  name               = "tp_status_ami"
  source_instance_id = "i-02aa3aae4e4df04ae"
}
resource "aws_ami_from_instance" "auth_ami" {
  name               = "tp_auth_ami"
  source_instance_id = "i-04fbf8701aa1c78af"
}
