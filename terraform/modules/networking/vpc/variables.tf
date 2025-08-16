variable "cidr_block_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "eks_name" {
  type    = string
  default = "eks_vpc_housing"
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}
