data "aws_eks_cluster_auth" "auth" {
  name = var.cluster_name
}
