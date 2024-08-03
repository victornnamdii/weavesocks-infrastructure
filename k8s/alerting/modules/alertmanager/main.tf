module "deployment" {
  source = "./deployment"
  configmap_name = var.configmap_name
  secret_name = var.secret_name
}

module "secret" {
  source = "./service"
}