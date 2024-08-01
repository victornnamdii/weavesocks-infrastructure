module "grafana_configMap" {
  source = "./grafana-configMap"
  namespace = var.namespace
}

module "prometheus_configMap" {
  source = "./prometheus-configMap"
  namespace = var.namespace
}