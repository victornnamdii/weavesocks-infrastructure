output "frontend_deployment_labels" {
  value = kubernetes_deployment.frontend_deployment.spec[0].selector[0].match_labels
}
