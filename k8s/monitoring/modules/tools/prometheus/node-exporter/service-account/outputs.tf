output "prometheus_node_exporter_sa_name" {
  value = kubernetes_service_account.prometheus_node_exporter_sa.metadata[0].name
}
