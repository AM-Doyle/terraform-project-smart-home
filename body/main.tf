
module "vpc" {
  source = "./modules/vpc"

  vpc_name           = var.vpc_name
  cidr_range         = var.cidr_range
  availability_zones = var.availability_zones_euw
  public_subnets     = var.cidr_public
  private_subnets    = var.cidr_private
}