module "grafana" {
  source = "./grafana"
  namespace = var.namespace
  secret_name = var.secret_name
  grafana_configmap_name = var.grafana_configmap_name
}

module "kube_state" {
  source = "./kube-state"
  namespace = var.namespace
}

module "prometheus" {
  source = "./prometheus"
  namespace = var.namespace
  prometheus_configmap_name = var.prometheus_configmap_name
}