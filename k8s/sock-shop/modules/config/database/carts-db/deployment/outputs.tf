output "carts_db_deployment_labels" {
  value = kubernetes_deployment.carts_db_deployment.metadata[0].labels
}