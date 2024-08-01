module "config" {
  source = "./modules/config"
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user = var.gf_security_admin_user
}

module "tools" {
  source = "./modules/tools"
  namespace = module.config.namespace
  secret_name = module.config.secret_name
  grafana_configmap_name = module.config.grafana_configmap_name
  prometheus_configmap_name = module.config.prometheus_configmap_name
}