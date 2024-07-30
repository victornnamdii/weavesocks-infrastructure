module "payment_deployment" {
  source = "./deployment"

  namespace = var.namespace
}

module "payment_service" {
  source = "./service"

  namespace                 = var.namespace
  payment_deployment_labels = module.payment_deployment.payment_deployment_labels
}
