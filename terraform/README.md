# Basic EKS Cluster with Terraform

This Terraform configuration creates a basic Amazon EKS cluster with the following components:

## Architecture

- **VPC**: Custom VPC with public and private subnets across 2 availability zones
- **EKS Cluster**: Managed Kubernetes cluster with logging enabled
- **Worker Nodes**: Managed node group in private subnets
- **IAM Roles**: Proper IAM roles and policies for EKS cluster and worker nodes
- **Networking**: Internet Gateway, NAT Gateways, and route tables

## Prerequisites

1. AWS CLI configured with appropriate permissions
2. Terraform >= 1.0 installed
3. kubectl installed (for cluster access)

## Required AWS Permissions

Your AWS user/role needs permissions for:
- EKS (full access)
- EC2 (VPC, subnets, security groups, instances)
- IAM (roles and policies)
- S3 and DynamoDB (for Terraform state)

## Deployment Steps

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Customize Configuration (Optional)
Copy the example variables file and modify as needed:
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your preferred values
```

### 3. Plan the Deployment
```bash
terraform plan
```

### 4. Deploy the Infrastructure
```bash
terraform apply
```

### 5. Configure kubectl
After deployment, configure kubectl to access your cluster:
```bash
aws eks --region eu-west-1 update-kubeconfig --name basic-eks-cluster
```

### 6. Verify the Cluster
```bash
kubectl get nodes
kubectl get pods -A
```

## Configuration Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `cluster_name` | Name of the EKS cluster | `basic-eks-cluster` |
| `region` | AWS region | `eu-west-1` |
| `kubernetes_version` | Kubernetes version | `1.29` |
| `vpc_cidr` | VPC CIDR block | `10.0.0.0/16` |
| `availability_zones` | List of AZs | `["eu-west-1a", "eu-west-1b"]` |
| `node_instance_types` | Worker node instance types | `["t3.medium"]` |
| `node_desired_size` | Desired number of worker nodes | `2` |
| `node_max_size` | Maximum number of worker nodes | `4` |
| `node_min_size` | Minimum number of worker nodes | `1` |

## Outputs

After deployment, you'll get important information including:
- Cluster endpoint
- VPC and subnet IDs
- IAM role ARNs
- kubectl configuration command

## Clean Up

To destroy the infrastructure:
```bash
terraform destroy
```

## Module Structure

```
├── main.tf                 # Main configuration
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── providers.tf            # Provider configuration
├── backend.tf              # S3 backend configuration
└── modules/
    ├── networking/
    │   ├── vpc/            # VPC module
    │   └── subnets/        # Subnets module
    ├── compute/
    │   ├── eks-cluster/    # EKS cluster module
    │   └── worker-nodes/   # Worker nodes module
    └── access/
        └── iam/            # IAM roles module
```

## Security Considerations

- Worker nodes are deployed in private subnets
- EKS cluster has both public and private endpoint access
- Proper IAM roles with least privilege principles
- Security groups are managed by EKS

## Cost Optimization

- Uses t3.medium instances by default (can be changed)
- NAT Gateways in each AZ (consider single NAT for cost savings in dev)
- EKS cluster logging enabled (generates CloudWatch costs)

## Troubleshooting

1. **Permission Issues**: Ensure your AWS credentials have sufficient permissions
2. **State Lock**: If terraform is stuck, check DynamoDB table for locks
3. **Node Group Issues**: Check IAM roles and subnet configurations
4. **kubectl Access**: Ensure you've run the update-kubeconfig command

## Next Steps

After deployment, you might want to:
1. Install AWS Load Balancer Controller
2. Set up cluster autoscaler
3. Configure monitoring with CloudWatch Container Insights
4. Set up ingress controllers
5. Deploy sample applications
