module "rabbitmq_deployment" {
  source    = "./deployment"
  namespace = var.namespace

}

module "rabbitmq_service" {
  source                     = "./service"
  namespace                  = var.namespace
  rabbitmq_deployment_labels = module.rabbitmq_deployment.rabbitmq_deployment_labels
}
