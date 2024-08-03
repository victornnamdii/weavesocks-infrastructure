module "configmap" {
  source = "./configMap"
}

module "secret" {
  source         = "./secret"
  slack_hook_url = var.slack_hook_url
}

module "ingress" {
  source                = "./ingress"
  alertmanager_svc_name = var.alertmanager_svc_name
  alertmanager_svc_port = var.alertmanager_svc_port
  domain_name           = var.domain_name
}
