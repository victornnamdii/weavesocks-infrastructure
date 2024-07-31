output "orders_deployment_labels" {
  value = kubernetes_deployment.orders_deployment.metadata[0].labels
}