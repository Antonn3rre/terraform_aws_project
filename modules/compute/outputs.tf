output "private_instances_ips" {
  value = aws_instance.private[*].private_ip
}
output "private_instances_ids" {
  value = aws_instance.private[*].id
}

output "bastion_subnet_id" {
  value = aws_instance.bastion.subnet_id
}
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
output "nat_interface_id" {
  value = aws_instance.nat.primary_network_interface_id
}
output "nat_public_ip" {
  value = aws_instance.nat.public_ip
}
output "nat_private_ip" {
  value = aws_instance.nat.private_ip
}
