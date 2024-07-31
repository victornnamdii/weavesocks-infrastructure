module "config" {
  source            = "./modules/config"
  mysql_db          = var.mysql_db
  mysql_password    = var.mysql_password
  user_db           = var.user_db
  java_opts         = var.java_opts
  zipkin            = var.zipkin
  frontend_svc_port = module.services.frontend_svc_port
  frontend_svc_name = module.services.frontend_svc_name
  domain_name       = var.domain_name
  session_redis     = var.session_redis
}

module "services" {
  source         = "./modules/services"
  configmap_name = module.config.configmap_name
  secret_name    = module.config.secret_name
  namespace      = module.config.namespace
}

module "utils" {
  source         = "./modules/utils"
  namespace      = module.config.namespace
  configmap_name = module.config.configmap_name
}
