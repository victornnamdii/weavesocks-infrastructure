output "prometheus_alertrules_configmap_name" {
  value = kubernetes_config_map.prometheus_alertrules_cm.metadata[0].name
}