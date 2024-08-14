module "carts_db" {
  source    = "./carts-db"
  namespace = var.namespace
}

module "catalogue_db" {
  source      = "./catalogue-db"
  namespace   = var.namespace
  secret_name = var.secret_name
}

module "orders_db" {
  source    = "./orders-db"
  namespace = var.namespace
}

module "session_db" {
  source    = "./session-db"
  namespace = var.namespace
}

module "user_db" {
  source      = "./user-db"
  namespace   = var.namespace
  secret_name = var.secret_name
}

