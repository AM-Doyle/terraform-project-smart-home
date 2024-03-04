# VPC
variable "availability_zones_euw" {
  type    = list(string)
}
variable "cidr_public" {
  type    = list(string)
}
variable "cidr_private" {
  type    = list(string)
}
variable "cidr_range" {
  type = string
}
variable "vpc_name" {
  type = string
}


