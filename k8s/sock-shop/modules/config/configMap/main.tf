resource "kubernetes_config_map" "sock_shop_config" {
  metadata {
    name      = "sock-shop-config"
    namespace = var.namespace
  }

  data = {
    java_opts     = var.java_opts
    zipkin        = var.zipkin
    session_redis = var.session_redis
  }
}
