resource "kubernetes_deployment" "alertmanager_dep" {
  metadata {
    name = "alertmanager"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "alertmanager"
      }
    }

    template {
      metadata {
        name = "alertmanager"

        labels = {
          app = "alertmanager"
        }
      }

      spec {
        init_container {
          name  = "init-config"
          image = "busybox:latest"
          command = [
            "/bin/sh",
            "-c",
            file("${path.module}/data/temp.sh")
          ]

          volume_mount {
            name       = "config-volume"
            mount_path = "/etc/alertmanager"
            read_only = true
          }

          volume_mount {
            name       = "config-writable"
            mount_path = "/etc/alertmanager-writable"
            read_only = false
          }
        }

        container {
          name  = "alertmanager"
          image = "prom/alertmanager:latest"

          env {
            name = "SLACK_HOOK_URL"

            value_from {
              secret_key_ref {
                name = var.secret_name
                key  = "slack-hook-url"
              }
            }
          }

          command = ["/bin/sh", "/etc/alertmanager-writable/configure_secret.sh"]
          args = [
            "--config.file=/etc/alertmanager-writable/config.yml",
            "--storage.path=/alertmanager"
          ]

          port {
            name           = "alertmanager"
            container_port = 9093
          }

          volume_mount {
            name       = "config-writable"
            mount_path = "/etc/alertmanager-writable"
            read_only = false
          }
        }

        volume {
          name = "config-volume"

          config_map {
            name = var.configmap_name
          }
        }

        volume {
          name = "config-writable"
          empty_dir {}
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
