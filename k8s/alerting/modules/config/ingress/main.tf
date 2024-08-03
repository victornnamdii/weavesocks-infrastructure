resource "kubernetes_ingress_v1" "alertmanager_ingress" {
  metadata {
    name = "alertmanager-ingress"
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = "alerting.${var.domain_name}"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.alertmanager_svc_name

              port {
                number = var.alertmanager_svc_port
              }
            }
          }
        }
      }
    }
  }
}
