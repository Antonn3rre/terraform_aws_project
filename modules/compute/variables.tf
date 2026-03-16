variable  "aws_region" {
  description = "Region where the instances are deployed"
  type = string
  default = "eu-west-3"
}

variable "bastion_name" {
  description = "Value of the 'Bastion' EC2 instance's Name tag"
  type = string
  default = "bastion"
}

variable  "bastion_type" {
  description = "The 'Bastion' EC2 instance's type"
  type = string
  default = "t3.micro"
}

variable "bastion_sg_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
  description = "List of public subnet IDs"
}
/*
variable "private_instances_sg_id" {
  type = list(string)
}
*/
