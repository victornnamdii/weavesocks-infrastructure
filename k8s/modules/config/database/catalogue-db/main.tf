module "catalogue_db_deployment" {
  source    = "./deployment"
  namespace = var.namespace
  secret_name = var.secret_name
}

module "catalogue_db_service" {
  source                     = "./service"
  namespace                  = var.namespace
  catalogue_db_deployment_labels = module.catalogue_db_deployment.catalogue_db_deployment_labels
}
