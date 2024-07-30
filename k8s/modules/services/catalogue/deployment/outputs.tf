output "catalogue_deployment_labels" {
  value = kubernetes_deployment.catalogue_deployment.metadata[0].labels
}
