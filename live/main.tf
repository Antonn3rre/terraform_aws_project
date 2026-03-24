data "aws_availability_zones" "available" { state = "available" }

module "compute" {
  source = "../modules/compute"
  bastion_sg_id = module.network_sec.bastion_sg_id
  public_subnets = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  privates_sg_id = module.network_sec.privates_sg_id
  nat_sg_id = module.network_sec.nat_sg_id
  vpc_cidr = module.vpc.vpc_cidr
}
  # module.vpc.public_subnets[0]

module "network_sec" {
  source = "../modules/network_sec"
  project_name = "Test"
  vpc_id = module.vpc.vpc_id
  allowed_ssh_cidrs = var.allowed_ssh_cidrs
  vpc_cidr = module.vpc.vpc_cidr
}

module "vpc" {
  source = "../modules/vpc"
  aws_availability_zones_names = data.aws_availability_zones.available.names
}

resource "aws_route" "private_nat_route" {
  count                  = length(module.vpc.private_subnets) # Plus fiable que les IDs de table ici
  route_table_id         = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = module.compute.nat_interface_id
  
  # On force Terraform à attendre que l'instance soit prête ET que le VPC soit stable
  depends_on = [module.compute, module.vpc]
}
