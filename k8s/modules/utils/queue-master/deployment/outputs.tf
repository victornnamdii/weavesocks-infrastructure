output "queue_master_deployment_labels" {
  value = kubernetes_deployment.queue_master_deployment.metadata[0].labels
}