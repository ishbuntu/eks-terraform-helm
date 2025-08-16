# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.cidr_block_vpc
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.eks_name
  }
}
