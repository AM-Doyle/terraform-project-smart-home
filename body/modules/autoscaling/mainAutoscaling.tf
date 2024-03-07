resource "aws_launch_template" "custom_launch_template" {

    count = length(var.app_names)

  name = var.app_names[count.index]

  instance_type          = var.lt_instance_type
  
  image_id = var.ec2_amis[count.index]

  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.subnet_ids[count.index]
    security_groups = var.security_group_ids

  }

}


resource "aws_autoscaling_group" "asgs" {

    count = length(var.app_names)

    name = "edit-${var.app_names[count.index]}"
  availability_zones = var.availability_zones[count.index]
  desired_capacity   = var.desired_instances
  max_size           = var.max_instances
  min_size           = var.min_instances

  launch_template {
    id      = aws_launch_template.custom_launch_template[count.index].id
  }
}

resource "aws_autoscaling_attachment" "example" {
    count = length(var.app_names)
  autoscaling_group_name = aws_autoscaling_group.asgs[count.index].id
  lb_target_group_arn    = var.target_group_arns[count.index]
}