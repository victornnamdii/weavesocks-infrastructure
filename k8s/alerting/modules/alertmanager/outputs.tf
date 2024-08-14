output "alertmanager_svc_name" {
  value = kubernetes_service.alertmanager_svc.metadata[0].name
}

output "alertmanager_svc_port" {
  value = kubernetes_service.alertmanager_svc.spec[0].port[0].port
}
