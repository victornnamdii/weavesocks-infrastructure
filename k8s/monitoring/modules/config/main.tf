module "configMap" {
  source    = "./configMap"
  namespace = module.namespace.namespace_name
}

module "namespace" {
  source = "./namespace"
}

module "secret" {
  source                     = "./secret"
  namespace                  = module.namespace.namespace_name
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user     = var.gf_security_admin_user
}

module "ingress" {
  source              = "./ingress"
  namespace           = module.namespace.namespace_name
  prometheus_svc_name = var.prometheus_svc_name
  prometheus_svc_port = var.prometheus_svc_port
  grafana_svc_name    = var.grafana_svc_name
  grafana_svc_port    = var.grafana_svc_port
  domain_name         = var.domain_name
}
