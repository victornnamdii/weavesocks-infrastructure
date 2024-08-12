module "deployment" {
  source      = "./deployment"
  namespace   = var.namespace
  secret_name = var.secret_name
}

module "service" {
  source             = "./service"
  namespace          = var.namespace
  grafana_dep_labels = module.deployment.grafana_dep_labels
}

module "grafana_config" {
  source                 = "./config"
  namespace              = var.namespace
  grafana_configmap_name = var.grafana_configmap_name

  depends_on = [module.service]
}
