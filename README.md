# Cloud DevOps Project – Kubernetes GitOps

**Tech Stack:** Terraform · AWS EKS · Kubernetes · ArgoCD · Helm · Docker · Prometheus · Grafana · Trivy

A cloud-native deployment pipeline for a Dockerized portfolio web application using GitOps principles.

## Project Overview

This project demonstrates a complete DevOps pipeline that provisions infrastructure, containerizes applications, and implements automated deployment with monitoring and security scanning.

## Architecture

```
GitHub Repo → ArgoCD → EKS Cluster → Portfolio App
     ↓           ↓         ↓            ↓
   Trivy    GitOps Sync  Helm Chart  LoadBalancer
```

## Features Implemented

### Infrastructure as Code
- **AWS EKS Cluster** - Kubernetes v1.29 with auto-scaling worker nodes
- **VPC & Networking** - Multi-AZ setup with public/private subnets and NAT gateways
- **IAM Security** - Least-privilege service roles for cluster and node groups
- **Terraform Modules** - Reusable infrastructure components

### Application Deployment
- **Flask Portfolio App** - Responsive web application with multiple pages
- **Docker Containerization** - Optimized container images stored in ECR
- **Helm Charts** - Templated Kubernetes manifests for consistent deployments
- **LoadBalancer Service** - External access via AWS Application Load Balancer

### GitOps Pipeline
- **ArgoCD Controller** - Automated deployment synchronization from Git
- **GitOps Repository** - Declarative configuration management
- **Continuous Deployment** - Hands-off deployment on Git commits
- **Application Health Monitoring** - Automatic rollback on deployment failures

### Monitoring & Observability
- **Prometheus Stack** - Comprehensive metrics collection and alerting
- **Grafana Dashboards** - Real-time visualization of cluster and application health
- **Service Monitoring** - Application performance and availability metrics
- **Log Aggregation** - Centralized logging for troubleshooting

### Security & CI/CD
- **Trivy Integration** - Container vulnerability scanning in CI pipeline
- **GitHub Actions** - Automated testing and security validation
- **Image Scanning** - Pre-deployment security checks
- **Policy Enforcement** - Security policies via Open Policy Agent

## Quick Start

### Prerequisites
- AWS CLI configured
- kubectl installed
- Helm 3.x installed
- Terraform installed

### Deploy Infrastructure
```bash
cd terraform
terraform init
terraform apply
```

### Configure kubectl
```bash
aws eks --region eu-west-1 update-kubeconfig --name eks-cluster
```

### Deploy Application
```bash
helm install portfolio-app ./helm-charts/portfolio-app
```

### Access Application
```bash
kubectl get svc portfolio-app -o wide
# Access via LoadBalancer EXTERNAL-IP
```

## Project Structure

```
├── terraform/                 # Infrastructure as Code
│   ├── modules/
│   │   ├── compute/           # EKS cluster & worker nodes
│   │   ├── networking/        # VPC, subnets, gateways
│   │   └── access/            # IAM roles & policies
│   └── main.tf
├── docker-app/                # Flask application
│   ├── app.py
│   ├── Dockerfile
│   └── templates/
├── helm-charts/               # Kubernetes deployment
│   └── portfolio-app/
│       ├── templates/
│       └── values.yaml
├── gitops-manifests/          # ArgoCD application configs
└── scripts/                   # Automation scripts
```

## Technologies Used

| Category | Technology | Purpose |
|----------|------------|---------|
| Infrastructure | Terraform | Infrastructure provisioning |
| Container Platform | AWS EKS | Managed Kubernetes service |
| Packaging | Helm | Application deployment |
| GitOps | ArgoCD | Continuous deployment |
| Monitoring | Prometheus/Grafana | Observability stack |
| Security | Trivy | Vulnerability scanning |
| Registry | AWS ECR | Container image storage |

## Key Achievements

- **Zero-downtime deployments** through GitOps automation
- **Infrastructure reproducibility** via Terraform modules
- **Security-first approach** with container scanning and policy enforcement
- **Comprehensive monitoring** with real-time alerting
- **Scalable architecture** supporting high availability and auto-scaling

## Learning Outcomes

- AWS EKS cluster management and networking configuration
- Infrastructure as Code best practices with Terraform
- Kubernetes application lifecycle management with Helm
- GitOps implementation for automated deployments
- Container security and vulnerability management
- Cloud-native monitoring and observability patterns
