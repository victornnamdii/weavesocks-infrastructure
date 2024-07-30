output "carts_deployment_labels" {
  value = kubernetes_deployment.carts_deployment.metadata[0].labels
}