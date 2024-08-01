output "grafana_dep_labels" {
  value = kubernetes_deployment.grafana.metadata[0].labels
}
