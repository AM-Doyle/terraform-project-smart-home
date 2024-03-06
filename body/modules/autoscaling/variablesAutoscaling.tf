variable "app_names" {
  type = list(string)
}
variable "lt_instance_type" {
  type = string
}
variable "ec2_amis" {
  type = list(string)
}
variable "key_name" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}

variable "availability_zones" {
  type = list(list(string))
}
variable "desired_instances" {
  type = number
}
variable "max_instances" {
  type = number
}
variable "min_instances" {
  type = number
}
variable "target_group_arns" {
  type = list(string)
}