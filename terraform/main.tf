# Local variables for configuration
locals {
  cluster_name = var.cluster_name
  region       = var.region
}

# VPC Module
module "vpc" {
  source = "./modules/networking/vpc"

  cidr_block_vpc   = var.vpc_cidr
  eks_name         = local.cluster_name
  instance_tenancy = "default"
}

# Subnets Module
module "subnets" {
  source = "./modules/networking/subnets"

  vpc_id               = module.vpc.vpc_id
  vpc_cidr_block       = var.vpc_cidr
  eks_cluster_name     = local.cluster_name
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# IAM Module for EKS
module "iam" {
  source = "./modules/access/iam"

  cluster_name = local.cluster_name
}

# EKS Cluster Module
module "eks_cluster" {
  source = "./modules/compute/eks-cluster"

  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids

  cluster_service_role_arn = module.iam.cluster_service_role_arn

  depends_on = [module.vpc, module.subnets, module.iam]
}

# Worker Nodes Module
module "worker_nodes" {
  source = "./modules/compute/worker-nodes"

  cluster_name           = local.cluster_name
  cluster_endpoint       = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = module.eks_cluster.cluster_ca_certificate

  private_subnet_ids = module.subnets.private_subnet_ids

  node_group_role_arn = module.iam.node_group_role_arn

  instance_types = var.node_instance_types
  desired_size   = var.node_desired_size
  max_size       = var.node_max_size
  min_size       = var.node_min_size

  depends_on = [module.eks_cluster]
}
