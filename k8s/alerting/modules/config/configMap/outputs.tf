output "alertmanager_configmap_name" {
  value = kubernetes_config_map.alertmanager_configmap.metadata[0].name
}
