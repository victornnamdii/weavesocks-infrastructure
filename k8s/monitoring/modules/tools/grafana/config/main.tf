module "import_dash_batch" {
  source                     = "./import-dash-batch"
  namespace                  = var.namespace
  grafana_configmap_name     = var.grafana_configmap_name
  gf_security_admin_password = var.gf_security_admin_password
  gf_security_admin_user     = var.gf_security_admin_user
}
