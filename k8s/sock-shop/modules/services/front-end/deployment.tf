resource "kubernetes_deployment" "frontend_deployment" {
  metadata {
    name      = "front-end"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "front-end"
      }
    }

    template {
      metadata {
        labels = {
          name = "front-end"
        }
      }

      spec {
        container {
          name  = "front-end"
          image = "weaveworksdemos/front-end:0.3.12"

          resources {
            limits = {
              cpu    = "300m"
              memory = "1000Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "300Mi"
            }
          }

          port {
            container_port = 8079
          }

          env {
            name = "SESSION_REDIS"
            value_from {
              config_map_key_ref {
                name = var.configmap_name
                key  = "session_redis"
              }
            }
          }

          security_context {
            run_as_non_root = true
            run_as_user     = "10001"

            capabilities {
              drop = ["all"]
            }

            read_only_root_filesystem = true
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8079
            }

            initial_delay_seconds = 300
            period_seconds        = 3
          }
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
