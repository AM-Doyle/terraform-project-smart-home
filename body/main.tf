
module "vpc" {
  source = "./modules/vpc"

  vpc_name           = var.vpc_name
  cidr_range         = var.cidr_range
  availability_zones = var.availability_zones_euw
  public_subnets     = var.cidr_public
  private_subnets    = var.cidr_private
}

module "security" {
  source = "./modules/security"

  vpc_id = module.vpc.vpc_id
  cidr_block = var.cidr_range
}

module "dynamo" {
  source = "./modules/dynamo"

  count = length(var.dynamo_table_names)

  table_name = var.dynamo_table_names[count.index]
  hash_key = var.dynamo_hash_keys[count.index]
  hash_key_type = var.dynamo_hash_key_type[count.index]
}

module "servers" {
  source = "./modules/servers"

  instance_type = var.instance_type
  public_subnets = module.vpc.public_subnet_ids
  private_subnets = [module.vpc.private_subnet_ids[0]]
  public_ec2_names = var.public_ec2_names
  private_ec2_names = var.private_ec2_names
  security_group_ids = module.security.security_group_ids
}

module "load_balancer" {
  source = "./modules/load_balancers"

  ec2_names = concat(var.public_ec2_names, var.private_ec2_names)
  tg_protocol = var.tg_protocol
  tg_port = var.tg_port
  tg_protocol_version = var.tg_protocol_version 
  vpc_id = module.vpc.vpc_id
  ec2_ids =  concat(module.servers.public_ec2_ids, module.servers.private_ec2_ids)
  load_balancer_type = var.load_balancer_type
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = module.security.security_group_ids
}