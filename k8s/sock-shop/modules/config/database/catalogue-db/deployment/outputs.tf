output "catalogue_db_deployment_labels" {
  value = kubernetes_deployment.catalogue_db_deployment.metadata[0].labels
}
