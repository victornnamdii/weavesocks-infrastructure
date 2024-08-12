module "aws" {
  source       = "./aws"
  cluster_name = var.cluster_name
}

module "helm" {
  source = "./helm"

  depends_on = [module.aws]
}

module "k8s" {
  source                     = "./k8s"
  session_redis              = var.session_redis
  java_opts                  = var.java_opts
  mysql_db                   = var.mysql_db
  mysql_password             = var.mysql_password
  zipkin                     = var.zipkin
  user_db                    = var.user_db
  domain_name                = var.domain_name
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user     = var.gf_security_admin_user
  slack_hook_url             = var.slack_hook_url
  certificate_email          = var.certificate_email

  depends_on = [module.helm]
}
