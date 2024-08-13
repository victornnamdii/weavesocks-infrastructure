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
  source                     = "./config"
  namespace                  = var.namespace
  grafana_configmap_name     = var.grafana_configmap_name
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user     = var.gf_security_admin_user

  depends_on = [module.service]
}
