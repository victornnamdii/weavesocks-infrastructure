module "frontend_deployment" {
  source         = "./deployment"
  namespace      = var.namespace
  configmap_name = var.configmap_name
}

module "frontend_service" {
  source                     = "./service"
  namespace                  = var.namespace
  frontend_deployment_labels = module.frontend_deployment.frontend_deployment_labels
}
