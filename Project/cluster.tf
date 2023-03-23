# Create EKS Cluster

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster-role.arn
  version  = "1.25"


  vpc_config {
    subnet_ids = [aws_subnet.private_subnets[var.private_subnets.private-1.key].id, aws_subnet.private_subnets[var.private_subnets.private-2.key].id]
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController,
  ]
}



