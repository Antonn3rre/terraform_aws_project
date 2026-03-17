output "private_instances_ips" {
  value = aws_instance.private[*].private_ip
}

output "bastion_subnet_id" {
  value = aws_instance.bastion.subnet_id
}
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
