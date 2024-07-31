output "session_db_deployment_labels" {
  value = kubernetes_deployment.session_db_deployment.metadata[0].labels
}
