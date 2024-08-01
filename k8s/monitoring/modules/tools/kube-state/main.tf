module "kube_state_config" {
  source    = "./config"
  namespace = var.namespace
}

module "deployment" {
  source    = "./deployment"
  namespace = var.namespace
}

module "service" {
  source                = "./service"
  namespace             = var.namespace
  kube_state_dep_labels = module.deployment.kube_state_dep_labels
}
