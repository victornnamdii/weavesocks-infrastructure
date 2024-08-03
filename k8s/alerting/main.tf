module "config" {
  source                = "./modules/config"
  slack_hook_url        = var.slack_hook_url
  alertmanager_svc_name = module.alertmanager.alertmanager_svc_name
  alertmanager_svc_port = module.alertmanager.alertmanager_svc_port
  domain_name           = var.domain_name
}

module "alertmanager" {
  source         = "./modules/alertmanager"
  configmap_name = module.config.configmap_name
  secret_name    = module.config.secret_name
}
