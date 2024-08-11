output "cluster_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "nodes_arn" {
  value = aws_iam_role.eks_nodes.arn
}