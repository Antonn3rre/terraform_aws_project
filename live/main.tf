data "aws_availability_zones" "available" { state = "available" }

module "compute" {
  source = "../modules/compute"
  bastion_sg_id = module.network_sec.bastion_sg_id
  public_subnets = module.vpc.public_subnets
}
  # module.vpc.public_subnets[0]

module "network_sec" {
  source = "../modules/network_sec"
  project_name = "Test"
  vpc_id = module.vpc.vpc_id
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
}

module "vpc" {
  source = "../modules/vpc"
  aws_availability_zones_names = data.aws_availability_zones.available.names
}
