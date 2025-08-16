variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_role_name" {
  type        = string
  description = "Name for the EKS cluster service role"
  default     = null
}

variable "node_group_role_name" {
  type        = string
  description = "Name for the EKS node group role"
  default     = null
}
