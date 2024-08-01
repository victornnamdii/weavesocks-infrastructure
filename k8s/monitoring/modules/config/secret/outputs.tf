output "secret_name" {
  value = kubernetes_secret.monitoring_secret.metadata[0].name
}