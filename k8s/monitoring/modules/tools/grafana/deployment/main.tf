resource "kubernetes_deployment" "grafana" {
  metadata {
    name      = "grafana-core"
    namespace = var.namespace

    labels = {
      app       = "grafana"
      component = "core"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app       = "grafana"
        component = "core"
      }
    }

    template {
      metadata {
        labels = {
          app       = "grafana"
          component = "core"
        }
      }

      spec {
        container {
          image             = "grafana/grafana:7.5.5"
          name              = "grafana-core"
          image_pull_policy = "IfNotPresent"

          resources {
            limits = {
              cpu    = "100m"
              memory = "100Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }

          env {
            name = "GF_SECURITY_ADMIN_USER"

            value_from {
              secret_key_ref {
                name = var.secret_name
                key  = "gf_security_admin_user"
              }
            }
          }

          env {
            name = "GF_SECURITY_ADMIN_PASSWORD"

            value_from {
              secret_key_ref {
                name = var.secret_name
                key  = "gf_security_admin_password"
              }
            }
          }

          readiness_probe {
            http_get {
              path = "/login"
              port = 3000
            }

            initial_delay_seconds = 30
            timeout_seconds       = 5
          }

          volume_mount {
            name       = "grafana-persistent-storage"
            mount_path = "/var/lib/grafana"
          }
        }

        volume {
          name = "grafana-persistent-storage"
          empty_dir {

          }
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
