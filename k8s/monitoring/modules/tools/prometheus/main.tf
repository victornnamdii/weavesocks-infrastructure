module "prometheus_config" {
  source    = "./config"
  namespace = var.namespace
}

module "deployment" {
  source                               = "./deployment"
  namespace                            = var.namespace
  prometheus_alertrules_configmap_name = module.prometheus_config.prometheus_alertrules_configmap_name
  prometheus_service_account_name      = module.prometheus_config.prometheus_service_account_name
  prometheus_configmap_name            = var.prometheus_configmap_name
}

module "service" {
  source                = "./service"
  namespace             = var.namespace
  prometheus_dep_labels = module.deployment.prometheus_dep_labels
}
