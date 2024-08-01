output "prometheus_service_account_name" {
  value = kubernetes_service_account_v1.prometheus_sa.metadata[0].name
}