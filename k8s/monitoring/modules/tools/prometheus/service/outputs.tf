output "prometheus_svc_name" {
  value = kubernetes_service.prometheus_service.metadata[0].name
}

output "prometheus_svc_port" {
  value = kubernetes_service.prometheus_service.spec[0].port[0].port
}
