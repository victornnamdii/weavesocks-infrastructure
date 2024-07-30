module "user_deployment" {
  source = "./deployment"

  namespace      = var.namespace
  secret_name    = var.secret_name
  configmap_name = var.configmap_name
}

module "user_service" {
  source = "./service"

  namespace              = var.namespace
  user_deployment_labels = module.user_deployment.user_deployment_labels
}
