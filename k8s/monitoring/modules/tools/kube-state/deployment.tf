resource "kubernetes_deployment" "kube_state" {
  metadata {
    name      = "kube-state-metrics"
    namespace = var.namespace

    labels = {
      "app.kubernetes.io/name"    = "kube-state-metrics"
      "app.kubernetes.io/version" = "2.1.0"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "kube-state-metrics"
      }
    }

    template {
      metadata {
        name = "kube-state"
        labels = {
          "app.kubernetes.io/name"    = "kube-state-metrics"
          "app.kubernetes.io/version" = "2.1.0"
        }
      }

      spec {
        container {
          name  = "kube-state-metrics"
          image = "k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.1.0"

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }

            initial_delay_seconds = 5
            timeout_seconds       = 5
          }

          port {
            name           = "http-metrics"
            container_port = 8080
          }

          port {
            name           = "telemetry"
            container_port = 8081
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 8081
            }

            initial_delay_seconds = 5
            timeout_seconds       = 5
          }

          security_context {
            run_as_user = "65534"
          }
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }

        service_account_name = kubernetes_service_account.kube_state_sa.metadata[0].name
      }
    }
  }
}
