module "shipping_deployment" {
  source = "./deployment"

  namespace      = var.namespace
  configmap_name = var.configmap_name
}

module "shipping_service" {
  source = "./service"

  namespace                  = var.namespace
  shipping_deployment_labels = module.shipping_deployment.shipping_deployment_labels
}
