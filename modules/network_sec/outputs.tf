output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "privates_sg_id" {
  value = aws_security_group.private_ssh.id
}
