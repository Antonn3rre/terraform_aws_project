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
