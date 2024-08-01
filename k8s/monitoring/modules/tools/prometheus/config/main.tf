module "alert_rules" {
  source    = "./alertrules"
  namespace = var.namespace
}

module "prometheus_cluster_role" {
  source = "./cluster-role"
}

module "prometheus_cluster_role_binding" {
  source                          = "./cluster-role-binding"
  namespace                       = var.namespace
  prometheus_cr_name              = module.prometheus_cluster_role.prometheus_cr_name
  prometheus_service_account_name = module.prometheus_service_account.prometheus_service_account_name
}

module "prometheus_service_account" {
  source    = "./service-account"
  namespace = var.namespace
}

module "exporter-disk-usage" {
  source    = "./exporter-disk-usage-ds"
  namespace = var.namespace
}

module "node_exporter" {
  source    = "./node-exporter"
  namespace = var.namespace
}

