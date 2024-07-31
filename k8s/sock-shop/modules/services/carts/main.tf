module "carts_deployment" {
  source = "./deployment"

  configmap_name = var.configmap_name
  namespace      = var.namespace

}

module "carts_service" {
  source = "./service"

  namespace               = var.namespace
  carts_deployment_labels = module.carts_deployment.carts_deployment_labels
}
