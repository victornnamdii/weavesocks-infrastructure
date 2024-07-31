module "user_db_deployment" {
  source    = "./deployment"
  namespace = var.namespace
}

module "user_db_service" {
  source                    = "./service"
  namespace                 = var.namespace
  user_db_deployment_labels = module.user_db_deployment.user_db_deployment_labels
}
