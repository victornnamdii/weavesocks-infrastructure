module "carts_db_deployment" {
  source    = "./deployment"
  namespace = var.namespace
}

module "carts_db_service" {
  source                     = "./service"
  namespace                  = var.namespace
  carts_db_deployment_labels = module.carts_db_deployment.carts_db_deployment_labels
}
