resource "kubernetes_secret" "sock_shop_secret" {
  metadata {
    name      = "sockshop-secret"
    namespace = kubernetes_namespace.sock-shop.metadata[0].name
  }
  type = "Opaque"
  data = {
    mysql_password = var.mysql_password
    mysql_db       = var.mysql_db
    user_db        = var.user_db
  }
}
