output "user_deployment_labels" {
  value = kubernetes_deployment.user_deployment.metadata[0].labels
}
