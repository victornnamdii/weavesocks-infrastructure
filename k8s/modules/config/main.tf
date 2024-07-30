module "configMap" {
  source        = "./configMap"
  namespace     = module.namespace.namespace_name
  java_opts     = var.java_opts
  zipkin        = var.zipkin
  session_redis = var.session_redis
}

module "ingress" {
  source            = "./ingress"
  namespace         = module.namespace.namespace_name
  frontend_svc_name = var.frontend_svc_name
  frontend_svc_port = var.frontend_svc_port
  domain_name       = var.domain_name
}

module "namespace" {
  source = "./namespace"
}

module "secret" {
  source         = "./secret"
  namespace      = module.namespace.namespace_name
  mysql_db       = var.mysql_db
  mysql_password = var.mysql_password
  user_db        = var.user_db
}

module "database" {
  source      = "./database"
  namespace   = module.namespace.namespace_name
  secret_name = module.secret.secret_name
}
