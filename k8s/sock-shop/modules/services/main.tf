module "carts" {
  source         = "./carts"
  configmap_name = var.configmap_name
  namespace      = var.namespace
}

module "catalogue" {
  source    = "./catalogue"
  namespace = var.namespace
}

module "front-end" {
  source         = "./front-end"
  configmap_name = var.configmap_name
  namespace      = var.namespace
}

module "orders" {
  source         = "./orders"
  configmap_name = var.configmap_name
  namespace      = var.namespace
}

module "payment" {
  source         = "./payment"
  configmap_name = var.configmap_name
  namespace      = var.namespace
}

module "shipping" {
  source         = "./shipping"
  configmap_name = var.configmap_name
  namespace      = var.namespace
}

module "user" {
  source         = "./user"
  configmap_name = var.configmap_name
  namespace      = var.namespace
  secret_name    = var.secret_name
}
