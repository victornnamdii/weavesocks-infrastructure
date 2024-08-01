output "grafana_configmap_name" {
  value = module.configMap.grafana_configmap_name
}

output "prometheus_configmap_name" {
  value = module.configMap.prometheus_configmap_name
}

output "namespace" {
  value = module.namespace.namespace_name
}

output "secret_name" {
  value = module.secret.secret_name
}
