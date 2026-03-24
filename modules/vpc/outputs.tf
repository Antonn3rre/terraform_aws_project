output "vpc_id" {
  description = "Id of the VPC"
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}
