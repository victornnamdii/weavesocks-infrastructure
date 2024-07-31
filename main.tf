module "k8s" {
  source         = "./k8s"
  session_redis  = var.session_redis
  java_opts      = var.java_opts
  mysql_db       = var.mysql_db
  mysql_password = var.mysql_password
  zipkin         = var.zipkin
  user_db        = var.user_db
  domain_name    = var.domain_name
}
