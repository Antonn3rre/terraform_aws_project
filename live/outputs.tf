output "private_instances_ips" {
  value = module.compute.private_instances_ips
}
output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}
output "bastion_subnet_id" {
  value = module.compute.bastion_subnet_id
}
output "nat_public_ip" {
  value = module.compute.nat_public_ip
}
output "nat_private_ip" {
  value = module.compute.nat_private_ip
}
output "alb_url" {
  value = module.alb.alb_url
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
