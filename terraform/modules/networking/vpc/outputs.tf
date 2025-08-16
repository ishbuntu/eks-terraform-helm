output "vpc_id" {
  value       = aws_vpc.eks_vpc.id
  description = "Value for the VPC ID"
}

output "vpc_cidr_block" {
  value       = aws_vpc.eks_vpc.cidr_block
  description = "CIDR block of the VPC"
}
