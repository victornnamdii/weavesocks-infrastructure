module "session_db_deployment" {
  source    = "./deployment"
  namespace = var.namespace
}

module "session_db_service" {
  source                       = "./service"
  namespace                    = var.namespace
  session_db_deployment_labels = module.session_db_deployment.session_db_deployment_labels
}
