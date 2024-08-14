resource "kubernetes_ingress_v1" "prom_grafana_ingress" {
  metadata {
    name      = "prom-grafana-ingress"
    namespace = kubernetes_namespace.monitoring.metadata[0].name

    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }

  spec {
    ingress_class_name = "external-ingress-nginx"

    rule {
      host = "prometheus.${var.domain_name}"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.prometheus_svc_name

              port {
                number = var.prometheus_svc_port
              }
            }
          }
        }
      }
    }

    rule {
      host = "grafana.${var.domain_name}"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.grafana_svc_name

              port {
                number = var.grafana_svc_port
              }
            }
          }
        }
      }
    }

    tls {
      hosts = [
        "prometheus.${var.domain_name}",
        "grafana.${var.domain_name}"
      ]
      secret_name = "tls-secret"
    }
  }
}
