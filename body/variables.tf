# VPC
variable "availability_zones_euw" {
  type = list(string)
}
variable "cidr_public" {
  type = list(string)
}
variable "cidr_private" {
  type = list(string)
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
variable "customamis" {
  type = list(string)
}
variable "ec2s_needed" {
  type = bool
}


# load_balancer
variable "tg_protocol" {
  type = string
}
variable "tg_port" {
  type = number
}
variable "tg_protocol_version" {
  type = string
}

variable "lb_internal" {
  type = bool
}
variable "load_balancer_type" {
  type = string
}


# autoscaling
variable "lt_instance_type" {
  type = string
}
variable "key_name" {
  type = string
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