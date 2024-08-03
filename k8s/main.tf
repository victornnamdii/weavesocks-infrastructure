module "sock-shop" {
  source         = "./sock-shop"
  session_redis  = var.session_redis
  java_opts      = var.java_opts
  mysql_db       = var.mysql_db
  mysql_password = var.mysql_password
  zipkin         = var.zipkin
  user_db        = var.user_db
  domain_name    = var.domain_name
}

module "monitoring" {
  source = "./monitoring"
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user = var.gf_security_admin_user
}

module "alerting" {
  source = "./alerting"
  slack_hook_url = var.slack_hook_url
}
