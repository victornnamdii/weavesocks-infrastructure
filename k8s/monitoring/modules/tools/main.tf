module "grafana" {
  source                     = "./grafana"
  namespace                  = var.namespace
  secret_name                = var.secret_name
  grafana_configmap_name     = var.grafana_configmap_name
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user     = var.gf_security_admin_user
}

module "kube_state" {
  source    = "./kube-state"
  namespace = var.namespace
}

module "prometheus" {
  source                    = "./prometheus"
  namespace                 = var.namespace
  prometheus_configmap_name = var.prometheus_configmap_name
}
