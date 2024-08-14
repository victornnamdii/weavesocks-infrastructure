output "secret_name" {
  value = kubernetes_secret.alertmanager_secret.metadata[0].name
}

output "configmap_name" {
  value = kubernetes_config_map.alertmanager_configmap.metadata[0].name
}