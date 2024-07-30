output "user_db_deployment_labels" {
  value = kubernetes_deployment.user_db_deployment.metadata[0].labels
}
