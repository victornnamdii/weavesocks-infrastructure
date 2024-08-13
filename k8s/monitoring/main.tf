module "config" {
  source                     = "./modules/config"
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user     = var.gf_security_admin_user
  prometheus_svc_name        = module.tools.prometheus_svc_name
  prometheus_svc_port        = module.tools.prometheus_svc_port
  grafana_svc_name           = module.tools.grafana_svc_name
  grafana_svc_port           = module.tools.grafana_svc_port
  domain_name                = var.domain_name
}

module "tools" {
  source                     = "./modules/tools"
  namespace                  = module.config.namespace
  secret_name                = module.config.secret_name
  grafana_configmap_name     = module.config.grafana_configmap_name
  prometheus_configmap_name  = module.config.prometheus_configmap_name
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user     = var.gf_security_admin_user
}
