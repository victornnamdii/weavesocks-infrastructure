resource "kubernetes_daemonset" "prometheus_node_exporter_daemonset" {
  metadata {
    name      = "node-exporter"
    namespace = var.namespace

    labels = {
      "app.kubernetes.io/component" = "exporter"
      "app.kubernetes.io/name"      = "node-exporter"
    }
  }

  spec {
    # strategy {
    #   rolling_update {
    #     max_unavailable = "10%"
    #   }

    #   type = "RollingUpdate"
    # }

    selector {
      match_labels = {
        "app.kubernetes.io/component" = "exporter"
        "app.kubernetes.io/name"      = "node-exporter"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/component" = "exporter"
          "app.kubernetes.io/name"      = "node-exporter"
        }
      }

      spec {
        container {
          args = [
            "--web.listen-address=0.0.0.0:9100",
            "--path.sysfs=/host/sys",
            "--path.rootfs=/host/root",
            "--no-collector.wifi",
            "--no-collector.hwmon",
            "--collector.filesystem.ignored-mount-points=^/(dev|proc|sys|var/lib/docker/.+|var/lib/kubelet/pods/.+)($|/)",
            "--collector.netclass.ignored-devices=^(veth.*)$",
            "--collector.netdev.device-exclude=^(veth.*)$"
          ]
          image = "quay.io/prometheus/node-exporter:v1.1.2"
          name  = "node-exporter"

          resources {
            limits = {
              cpu    = "250m"
              memory = "180Mi"
            }

            requests = {
              cpu    = "102m"
              memory = "180Mi"
            }
          }

          volume_mount {
            mount_path        = "/host/sys"
            mount_propagation = "HostToContainer"
            name              = "sys"
            read_only         = true
          }

          volume_mount {
            mount_path        = "/host/root"
            mount_propagation = "HostToContainer"
            name              = "root"
            read_only         = true
          }

          port {
            container_port = 9100
            host_port      = 9100
            name           = "http"
          }
        }

        host_network = true
        host_pid     = true

        node_selector = {
          "kubernetes.io/os" = "linux"
        }

        security_context {
          run_as_non_root = true
          run_as_user     = "65534"
        }

        service_account_name = var.prometheus_node_exporter_sa_name

        toleration {
          operator = "Exists"
        }

        volume {
          host_path {
            path = "/sys"
          }

          name = "sys"
        }

        volume {
          host_path {
            path = "/"
          }

          name = "root"
        }
      }
    }
  }
}
