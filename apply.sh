#!/bin/bash

cd ../eks-arquitetura-microservices-modules/
echo "Create  VPC"

rm -rf  .terraform

terraform init

sleep 2

terraform workspace select dev-us-east-2

sleep 3

terraform apply --target=module.network_eks_base_core --auto-approve



cd ../Projeto-Final-EKS-ArgoCD/ingress/

echo "Setup do Ingress"

rm -rf  .terraform

terraform init -backend-config=environment/prod/backend.tfvars

terraform apply -var-file=environment/prod/terraform.tfvars --auto-approve



cd ../clusters

echo "Setup do Cluster 01"

rm -rf  .terraform

terraform init -backend-config=environment/prod/cluster-01/backend.tfvars --upgrade

terraform apply -var-file=environment/prod/cluster-01/terraform.tfvars --auto-approve



echo "Setup do Cluster 02"

rm -rf  .terraform

terraform init -backend-config=environment/prod/cluster-02/backend.tfvars --upgrade

terraform apply -var-file=environment/prod/cluster-02/terraform.tfvars --auto-approve


echo "Control Plane - ArgoCD"
cd ../control-plane

rm -rf  .terraform

terraform init -backend-config=environment/prod/backend.tfvars

terraform apply -var-file=environment/prod/terraform.tfvars --auto-approve


echo "Setup do Cluster de Observabilidade"

cd ../observability-cluster

rm -rf  .terraform

terraform init -backend-config=environment/prod/backend.tfvars

terraform apply -var-file=environment/prod/terraform.tfvars --auto-approve