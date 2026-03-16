variable "allowed_ssh_cidrs" {
  type = list(string)
}

variable "aws_region" {
  type = string
  default = "eu-west-3"
}
