output "cluster_service_role_arn" {
  value       = aws_iam_role.cluster.arn
  description = "ARN of the EKS cluster service role"
}

output "node_group_role_arn" {
  value       = aws_iam_role.node_group.arn
  description = "ARN of the EKS node group role"
}

output "cluster_role_name" {
  value       = aws_iam_role.cluster.name
  description = "Name of the EKS cluster service role"
}

output "node_group_role_name" {
  value       = aws_iam_role.node_group.name
  description = "Name of the EKS node group role"
}
