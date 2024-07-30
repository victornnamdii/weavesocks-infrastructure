resource "kubernetes_secret" "sock_shop_secret" {
  metadata {
    name      = "sockshop-secret"
    namespace = var.namespace
  }
  type = "Opaque"
  data = {
    mysql_password = var.mysql_password
    mysql_db       = var.mysql_db
    user_db        = var.user_db
  }
}
