output "grafana_configmap_name" {
  value = kubernetes_config_map.grafana_cm.metadata[0].name
}