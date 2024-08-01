output "grafana_configmap_name" {
  value = module.grafana_configMap.grafana_configmap_name
}

output "prometheus_configmap_name" {
  value = module.prometheus_configMap.prometheus_configmap_name
}