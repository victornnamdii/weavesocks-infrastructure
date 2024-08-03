module "config" {
  source         = "./modules/config"
  slack_hook_url = var.slack_hook_url
}

module "alertmanager" {
  source         = "./modules/alertmanager"
  configmap_name = module.config.configmap_name
  secret_name    = module.config.secret_name
}
