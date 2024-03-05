variable "ec2_names" {
  type = list(string)
}
variable "tg_protocol" {
  type = string
}
variable "tg_port" {
  type = string
}
variable "tg_protocol_version" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "ec2_ids" {
  type = list(string)
}
variable "load_balancer_type" {
  type = string
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}