resource "kubernetes_ingress_v1" "prom_grafana_ingress" {
  metadata {
    name      = "prom-grafana-ingress"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"

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
  }
}
