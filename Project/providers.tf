terraform {
  required_providers { 
    namedotcom = {
      source  = "lexfrei/namedotcom"
      version = "1.2.5"
    }    
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0"
    }
  } 
}

provider "aws" {
  region = var.aws_region
}

provider "namedotcom" {
  username = var.namedotcom_username
  token    = var.namedotcom_token
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  
  depends_on = [
    aws_eks_cluster.cluster
  ]
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    } 
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    command     = "aws"
  }
}

