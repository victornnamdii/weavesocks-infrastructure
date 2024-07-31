module "orders_deployment" {
  source = "./deployment"

  namespace      = var.namespace
  configmap_name = var.configmap_name
}

module "orders_service" {
  source = "./service"

  namespace                = var.namespace
  orders_deployment_labels = module.orders_deployment.orders_deployment_labels
}
