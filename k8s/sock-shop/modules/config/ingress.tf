resource "kubernetes_ingress_v1" "sock_shop_ingress" {
  metadata {
    name      = "sockshop-ingress"
    namespace = kubernetes_namespace.sock-shop.metadata[0].name

    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }

  spec {
    ingress_class_name = "external-ingress-nginx"

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

    rule {
      host = "www.${var.domain_name}"

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

    tls {
      hosts       = [var.domain_name, "www.${var.domain_name}"]
      secret_name = "tls-secret"
    }
  }
}
