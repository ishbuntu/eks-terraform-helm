# VPC Outputs
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "CIDR block of the VPC"
}

# Subnet Outputs
output "public_subnet_ids" {
  value       = module.subnets.public_subnet_ids
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = module.subnets.private_subnet_ids
  description = "List of private subnet IDs"
}

# EKS Cluster Outputs
output "cluster_id" {
  value       = module.eks_cluster.cluster_id
  description = "EKS cluster ID"
}

output "cluster_arn" {
  value       = module.eks_cluster.cluster_arn
  description = "EKS cluster ARN"
}

output "cluster_endpoint" {
  value       = module.eks_cluster.cluster_endpoint
  description = "EKS cluster endpoint"
}

output "cluster_version" {
  value       = module.eks_cluster.cluster_version
  description = "EKS cluster Kubernetes version"
}

output "cluster_security_group_id" {
  value       = module.eks_cluster.cluster_security_group_id
  description = "Security group ID attached to the EKS cluster"
}

output "cluster_oidc_issuer_url" {
  value       = module.eks_cluster.cluster_oidc_issuer_url
  description = "The URL on the EKS cluster OIDC Issuer"
}

# Worker Nodes Outputs
output "node_group_arn" {
  value       = module.worker_nodes.node_group_arn
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
}

output "node_group_status" {
  value       = module.worker_nodes.node_group_status
  description = "Status of the EKS Node Group"
}

# IAM Outputs
output "cluster_service_role_arn" {
  value       = module.iam.cluster_service_role_arn
  description = "ARN of the EKS cluster service role"
}

output "node_group_role_arn" {
  value       = module.iam.node_group_role_arn
  description = "ARN of the EKS node group role"
}

# kubectl configuration command
output "configure_kubectl" {
  value       = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks_cluster.cluster_id}"
  description = "Command to configure kubectl"
}
