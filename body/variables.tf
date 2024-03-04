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


# dynamo\
variable "dynamo_table_names" {
  type = list(string)
}
variable "dynamo_hash_keys" {
  type = list(string)
}
variable "dynamo_hash_key_type" {
  type = list(string)
}

# servers
variable "instance_type" {
  type = string
}
variable "public_ec2_names" {
  type = list(string)
}
variable "private_ec2_names" {
  type = list(string)
}