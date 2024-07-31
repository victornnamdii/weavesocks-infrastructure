module "queue_master_deployment" {
  source         = "./deployment"
  configmap_name = var.configmap_name
  namespace      = var.namespace

}

module "queue_master_service" {
  source                         = "./service"
  namespace                      = var.namespace
  queue_master_deployment_labels = module.queue_master_deployment.queue_master_deployment_labels
}
