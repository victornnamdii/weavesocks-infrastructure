output "prometheus_configmap_name" {
  value = kubernetes_config_map.prometheus_cm.metadata[0].name
}