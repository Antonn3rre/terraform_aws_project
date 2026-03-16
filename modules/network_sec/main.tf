resource "aws_security_group" "bastion" {
  name_prefix = "${var.project_name}-bastion-"
  vpc_id = var.vpc_id
  description = "Security group for bastion host"

  # SSH access only from corporate IP ranges
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
    description = "SSH from allowed networks"
  }

  # Allow all outbound traffic to reach private instances
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name = "${var.project_name}-bastion-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Security group for private instances that accept SSH from the bastion
resource "aws_security_group" "private_ssh" {
  name_prefix = "${var.project_name}-private-ssh-"
  vpc_id      = var.vpc_id
  description = "Allow SSH from bastion host"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
    description     = "SSH from bastion host only"
  }

  tags = {
    Name = "${var.project_name}-private-ssh-sg"
  }
}
