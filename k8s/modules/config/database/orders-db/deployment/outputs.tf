output "orders_db_deployment_labels" {
  value = kubernetes_deployment.orders_db_deployment.metadata[0].labels
}
