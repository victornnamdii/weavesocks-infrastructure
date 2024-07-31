module "orders_db_deployment" {
  source    = "./deployment"
  namespace = var.namespace
}

module "orders_db_service" {
  source                      = "./service"
  namespace                   = var.namespace
  orders_db_deployment_labels = module.orders_db_deployment.orders_db_deployment_labels
}
