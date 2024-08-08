output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.eks.cluster_ca_certificate
}

output "token" {
  value = data.aws_eks_cluster_auth.auth.token
}
