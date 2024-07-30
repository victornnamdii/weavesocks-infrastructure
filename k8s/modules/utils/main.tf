module "rabbitmq" {
  source         = "./rabbitmq"
  namespace      = var.namespace
  configmap_name = var.configmap_name
}

module "queue_master" {
  source         = "./queue-master"
  namespace      = var.namespace
  configmap_name = var.configmap_name
}
