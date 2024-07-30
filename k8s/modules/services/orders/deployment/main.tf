resource "kubernetes_deployment" "orders_deployment" {
  metadata {
    name      = "orders"
    namespace = var.namespace

    labels = {
      name = "orders"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "orders"
      }
    }

    template {
      metadata {
        labels = {
          name = "orders"
        }
      }

      spec {
        container {
          name  = "orders"
          image = "weaveworksdemos/orders:0.4.7"

          env {
            name = "JAVA_OPTS"

            value_from {
              config_map_key_ref {
                name = var.configmap_name
                key  = "java_opts"
              }
            }
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "500Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "300Mi"
            }
          }

          port {
            container_port = 80
          }

          security_context {
            run_as_non_root = true
            run_as_user     = "10001"

            capabilities {
              drop = ["all"]
              add  = ["NET_BIND_SERVICE"]
            }

            read_only_root_filesystem = true
          }

          volume_mount {
            mount_path = "/tmp"
            name       = "tmp-volume"
          }
        }

        volume {
          name = "tmp-volume"
          empty_dir {
            medium = "Memory"
          }
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
