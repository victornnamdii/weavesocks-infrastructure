resource "kubernetes_deployment" "rabbitmq_deployment" {
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace

    labels = {
      name = "rabbitmq"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "rabbitmq"
      }
    }

    template {
      metadata {
        labels = {
          name = "rabbitmq"
        }

        annotations = {
          "prometheus.io/scrape" = "false"
        }
      }

      spec {
        container {
          name  = "rabbitmq"
          image = "rabbitmq:3.6.8-management"

          port {
            container_port = 15672
            name           = "management"
          }

          port {
            container_port = 5672
            name           = "rabbitmq"
          }

          security_context {
            capabilities {
              drop = ["all"]
              add  = ["CHOWN", "SETGID", "SETUID", "DAC_OVERRIDE"]
            }

            read_only_root_filesystem = true
          }
        }

        container {
          name  = "rabbitmq-exporter"
          image = "kbudde/rabbitmq-exporter"

          port {
            container_port = 9090
            name           = "exporter"
          }
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
