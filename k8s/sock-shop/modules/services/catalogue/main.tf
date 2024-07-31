module "catalogue_deployment" {
  source = "./deployment"

  namespace = var.namespace

}

module "catalogue_service" {
  source = "./service"

  namespace                   = var.namespace
  catalogue_deployment_labels = module.catalogue_deployment.catalogue_deployment_labels
}
