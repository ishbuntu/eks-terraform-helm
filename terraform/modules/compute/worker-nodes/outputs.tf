output "node_group_arn" {
  value       = aws_eks_node_group.main.arn
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
}

output "node_group_status" {
  value       = aws_eks_node_group.main.status
  description = "Status of the EKS Node Group"
}

output "node_group_capacity_type" {
  value       = aws_eks_node_group.main.capacity_type
  description = "Type of capacity associated with the EKS Node Group"
}

output "node_group_instance_types" {
  value       = aws_eks_node_group.main.instance_types
  description = "Set of instance types associated with the EKS Node Group"
}

output "node_group_remote_access_ec2_ssh_key" {
  value       = try(aws_eks_node_group.main.remote_access[0].ec2_ssh_key, null)
  description = "EC2 Key Pair name that provides access for SSH communication with the worker nodes"
}
