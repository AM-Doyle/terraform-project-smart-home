variable "instance_type" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "public_ec2_names" {
  type = list(string)
}
variable "private_ec2_names" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
variable "customamis" {
  type = list(string)
}
variable "ec2s_needed" {
  type = bool
}