module "daemon_set" {
  source                           = "./daemonset"
  namespace                        = var.namespace
  prometheus_node_exporter_sa_name = module.service_account.prometheus_node_exporter_sa_name
}

module "service_account" {
  source    = "./service-account"
  namespace = var.namespace
}

module "service" {
  source    = "./service"
  namespace = var.namespace
}
