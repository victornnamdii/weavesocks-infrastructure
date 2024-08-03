module "configmap" {
  source = "./configMap"
}

module "secret" {
  source = "./secret"
  slack_hook_url = var.slack_hook_url
}