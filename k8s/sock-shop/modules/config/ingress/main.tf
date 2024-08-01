resource "kubernetes_ingress_v1" "sock_shop_ingress" {
  metadata {
    name      = "sockshop-ingress"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"
  
    rule {
      host = var.domain_name

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.frontend_svc_name

              port {
                number = var.frontend_svc_port
              }
            }
          }
        }
      }
    }
  }
}
