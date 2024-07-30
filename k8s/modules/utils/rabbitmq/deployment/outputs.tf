output "rabbitmq_deployment_labels" {
  value = kubernetes_deployment.rabbitmq_deployment.metadata[0].labels
}
