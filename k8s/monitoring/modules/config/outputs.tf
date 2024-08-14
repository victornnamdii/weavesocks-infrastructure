output "grafana_configmap_name" {
  value = kubernetes_config_map.grafana_cm.metadata[0].name
}

output "prometheus_configmap_name" {
  value = kubernetes_config_map.prometheus_cm.metadata[0].name
}

output "namespace" {
  value = kubernetes_namespace.monitoring.metadata[0].name
}

output "secret_name" {
  value = kubernetes_secret.monitoring_secret.metadata[0].name
}
