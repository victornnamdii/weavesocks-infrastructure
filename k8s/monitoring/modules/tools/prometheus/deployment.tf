resource "kubernetes_deployment" "prometheus" {
  metadata {
    name      = "prometheus-deployment"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    strategy {
      rolling_update {
        max_surge       = 0
        max_unavailable = 1
      }

      type = "RollingUpdate"
    }

    selector {
      match_labels = {
        app = "prometheus"
      }
    }

    template {
      metadata {
        name = "prometheus"
        labels = {
          app = "prometheus"
        }
      }

      spec {
        service_account_name = kubernetes_service_account_v1.prometheus_sa.metadata[0].name
        container {
          name  = "prometheus"
          image = "prom/prometheus:v2.26.0"
          args = [
            "--storage.tsdb.retention=360h",
            "--config.file=/etc/prometheus/prometheus.yml"
          ]

          port {
            name           = "web"
            container_port = 9090
          }

          volume_mount {
            name       = "config-volume"
            mount_path = "/etc/prometheus"
          }

          volume_mount {
            name       = "alertrules-volume"
            mount_path = "/etc/prometheus-rules"
          }
        }

        volume {
          name = "config-volume"

          config_map {
            name = var.prometheus_configmap_name
          }
        }

        volume {
          name = "alertrules-volume"

          config_map {
            name = kubernetes_config_map.prometheus_alertrules_cm.metadata[0].name
          }
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
