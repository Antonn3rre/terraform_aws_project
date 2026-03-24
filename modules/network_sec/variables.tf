variable "vpc_id" {
  type = string
  description = "The ID of the VPC"
}

variable "allowed_ssh_cidrs" {
  type = list(string)
  description = ""
}

variable "project_name" {
  type = string
  description = "Projet name"
  default = "VPC AWS Terraform"
}

variable "vpc_cidr" {
  type = string
}
