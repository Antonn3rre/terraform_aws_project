variable "vpc_cidr" {
  description = "Value of CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "aws_availability_zones_names" {
  type        = list(string)
  description = "List of AZ names passed from root"
}
