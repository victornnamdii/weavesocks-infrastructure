output "cluster_endpoint" {
  value = aws_eks_cluster.sock_shop_eks.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.sock_shop_eks.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.sock_shop_eks.name
}