terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.14.1"
    }
  }
}

provider "kubernetes" {
  host                   = module.aws.cluster_endpoint
  cluster_ca_certificate = base64decode(module.aws.cluster_ca_certificate)
  token                  = module.aws.token
}

provider "helm" {
  kubernetes {
    host                   = module.aws.cluster_endpoint
    cluster_ca_certificate = base64decode(module.aws.cluster_ca_certificate)
    token                  = module.aws.token
  }
}

provider "aws" {
  region = "us-east-1"
}
