# Create EKS Cluster node group

resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "altschool-exam-node-group"
  node_role_arn   = aws_iam_role.nodes-role.arn
  instance_types = ["t2.medium"]
  subnet_ids      = [aws_subnet.private_subnets[var.private_subnets.private-1.key].id, aws_subnet.private_subnets[var.private_subnets.private-2.key].id]

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}
