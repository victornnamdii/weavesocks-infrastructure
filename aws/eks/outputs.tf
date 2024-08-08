output "cluster_endpoint" {
  value = aws_eks_cluster.sock_shop_cluster.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.sock_shop_cluster.certificate_authority[0].data
}
