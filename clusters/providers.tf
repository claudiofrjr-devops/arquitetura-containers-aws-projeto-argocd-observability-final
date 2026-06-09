terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
      command     = "aws"
    }
  }
}

provider "kubectl" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
    command     = "aws"
  }
}










# provider "aws" {
#   region = var.region
# }

# terraform {
#   required_providers {
#     kubectl = {
#       source  = "gavinbunney/kubectl"
#       version = ">= 1.7.0"
#     }
#   }
# }

# provider "kubernetes" {
#   host                   = aws_eks_cluster.main.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.default.token
# }


# provider "helm" {
#   kubernetes {
#     host                   = aws_eks_cluster.main.endpoint
#     cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
#     token                  = data.aws_eks_cluster_auth.default.token
#   }
# }

# provider "kubectl" {
#   host                   = aws_eks_cluster.main.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.default.token
# }