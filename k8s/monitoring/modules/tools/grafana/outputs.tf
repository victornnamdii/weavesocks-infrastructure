output "grafana_svc_name" {
  value = kubernetes_service.grafana_service.metadata[0].name
}

output "grafana_svc_port" {
  value = kubernetes_service.grafana_service.spec[0].port[0].port
}
