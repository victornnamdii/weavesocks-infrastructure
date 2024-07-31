output "payment_deployment_labels" {
  value = kubernetes_deployment.payment_deployment.metadata[0].labels
}
