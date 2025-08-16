#!/bin/bash

# This script will build a DockerFile locally, tag the image & push the image to ECR
# Ready for EKS worker nodes to pull into EKS
# Config 
REGION="eu-west-1"
REPO_NAME="portfolio-app"
IMAGE_TAG="latest"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq --raw-output '.Account')
ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}"


echo "Starting ECR deployment Process..."
echo "=================================="
echo "Account ID: $AWS_ACCOUNT_ID"
echo "Region: $REGION"
echo "Repository name: $REPO_NAME"
echo "ECR URI: $ECR_URI"

# Create ECR Repository
echo "Creating ECR Repository..."
echo "=================================="
aws ecr create-repository --repository-name ${REPO_NAME} --region ${REGION} 2>/dev/null || echo "The repository ${REPO_NAME}: already exists"
if [ $? -ne -0 ]; then
  echo -e "Repository creation failed!"
  exit 1 
fi

# Handle ECR authentication
echo "Fetching password and auth tokens for ECR..."
echo "=================================="
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URI
if [ $? -ne 0 ]; then 
  echo -e "Failed to get authentication token for ECR"
  exit 1 
fi 

# Build Docker Image 
docker build -t $REPO_NAME:$IMAGE_TAG . 
echo "Building and tagging Docker image..."
if [ $? -ne -0 ]; then
  echo -e "Docker Build Failed!!!"
  exit 1 
fi

# Tag for ECR 
echo "Tagging your image for ECR..."
docker tag $REPO_NAME:$IMAGE_TAG $ECR_URI:$IMAGE_TAG 
if [ $? -ne -0 ]; then
  echo -e "Image tagging failed"
  exit 1 
fi


# Push image to ECR
echo "Pushing to ECR..."
docker push $ECR_URI:$IMAGE_TAG
if [ $? -ne 0 ]; then 
  echo "push to ECR failed"
  exit 1 
fi 

echo -e "Image URI: $ECR_URI:$IMAGE_TAG"

echo $ECR_URI:$IMAGE_TAG > ../image-uri.txt
echo -e "Image URI saved to image-uri.txt"

