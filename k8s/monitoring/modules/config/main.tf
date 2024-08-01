module "configMap" {
  source = "./configMap"
  namespace = module.namespace.namespace_name
}

module "namespace" {
  source = "./namespace"
}

module "secret" {
  source = "./secret"
  namespace = module.namespace.namespace_name
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user = var.gf_security_admin_user
}