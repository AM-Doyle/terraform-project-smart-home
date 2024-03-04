
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