# Define AMI (Amazon Machine Image)
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}


## BASTION

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.bastion_type

  key_name = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [var.bastion_sg_id]
  subnet_id = var.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Name = var.bastion_name
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "mon-projet-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

## PRIVATE INSTANCES
resource "aws_instance" "private" {
  count = 2

  ami = data.aws_ami.ubuntu.id
  instance_type = var.private_instances_type

  key_name = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [var.privates_sg_id]

  subnet_id = var.private_subnets[count.index]
  tags = {
    Name = "private_${count.index}"
  }
}


