module "database" {
  source      = "./database"
  secret_name = kubernetes_secret.sock_shop_secret.metadata[0].name
  namespace   = kubernetes_namespace.sock-shop.metadata[0].name
}
