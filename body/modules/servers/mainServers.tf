data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "public_ec2s" {

  count = var.ec2s_needed ? length(var.public_subnets) : 0

  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[count.index]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = var.customamis[count.index]
  associate_public_ip_address = true
  key_name                    = "tfIntroKey"

  tags = {
    Name = var.public_ec2_names[count.index]
  }
}
resource "aws_instance" "private_ec2s" {

  count = var.ec2s_needed ? length(var.private_subnets) : 0

  instance_type               = var.instance_type
  subnet_id                   = var.private_subnets[count.index]
  vpc_security_group_ids      = var.security_group_ids
  ami                         = var.customamis[3]
  associate_public_ip_address = true
  key_name                    = "tfIntroKey"

  tags = {
    Name = var.private_ec2_names[count.index]
  }

}