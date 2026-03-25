variable "alb_sg_id" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "private_instances_ids" {
  type =  list(string)
}

