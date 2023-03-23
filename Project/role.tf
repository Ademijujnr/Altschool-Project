# Define variables
variable "worker_node_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "cni_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "ecr_read_only_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

variable "cluster_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

variable "vpc_resource_controller_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

# Create IAM role for eks nodes
resource "aws_iam_role" "nodes-role" {
  name = "nodes-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach required policies to eks node role
resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = var.worker_node_policy_arn
  role       = aws_iam_role.nodes-role.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = var.cni_policy_arn
  role       = aws_iam_role.nodes-role.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = var.ecr_read_only_policy_arn
  role       = aws_iam_role.nodes-role.name
}

# Create IAM role for eks cluster
resource "aws_iam_role" "cluster-role" {
  name = "cluster-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach required policies to eks cluster role
resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  policy_arn = var.cluster_policy_arn
  role       = aws_iam_role.cluster-role.name
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSVPCResourceController" {
  policy_arn = var.vpc_resource_controller_policy_arn
  role       = aws_iam_role.cluster-role.name
}
