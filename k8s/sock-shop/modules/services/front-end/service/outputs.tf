output "frontend_svc_name" {
  value = kubernetes_service.frontend_service.metadata[0].name
}

output "frontend_svc_port" {
  value = kubernetes_service.frontend_service.spec[0].port[0].port
}
