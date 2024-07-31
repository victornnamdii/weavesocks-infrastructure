resource "kubernetes_deployment" "queue_master_deployment" {
  metadata {
    name      = "queue-master"
    namespace = var.namespace

    labels = {
      name = "queue-master"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "queue-master"
      }
    }

    template {
      metadata {
        labels = {
          name = "queue-master"
        }
      }

      spec {
        container {
          name  = "queue-master"
          image = "weaveworksdemos/queue-master:0.3.1"

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
              cpu    = "300m"
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
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
