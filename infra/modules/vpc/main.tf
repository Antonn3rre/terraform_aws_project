locals {
  # Number of azs we wan't to use
  az_count = 2
  azs = slice(var.aws_availability_zones_names, 0, local.az_count)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "vpc"
  # If CIDR = 10.0.0.0/16 range go to 10.10.255.254
  cidr = var.vpc_cidr

  # Availabililty zones
  azs             = local.azs

  map_public_ip_on_launch = true
  # If 2 azs and 2 subnets, they are each put in 1 az

  # Generate dynamically the ${az.count} adresses based on the CIDR block value
  private_subnets = [for i in range(local.az_count) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets  = [for i in range(local.az_count) : cidrsubnet(var.vpc_cidr, 8, i + 10)]

  enable_dns_hostnames    = true
}
