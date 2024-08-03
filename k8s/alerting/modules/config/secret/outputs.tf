output "alertmanager_secret_name" {
  value = kubernetes_secret.alertmanager_secret.metadata[0].name
}