output "shipping_deployment_labels" {
  value = kubernetes_deployment.shipping_deployment.metadata[0].labels
}