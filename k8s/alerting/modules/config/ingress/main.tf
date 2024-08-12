resource "kubernetes_ingress_v1" "alertmanager_ingress" {
  metadata {
    name = "alertmanager-ingress"

    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }

  spec {
    ingress_class_name = "external-ingress-nginx"

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

    tls {
      hosts       = ["alerting.${var.domain_name}"]
      secret_name = "tls-secret"
    }
  }
}
