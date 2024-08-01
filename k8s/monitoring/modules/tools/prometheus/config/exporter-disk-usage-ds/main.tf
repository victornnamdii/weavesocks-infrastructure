resource "kubernetes_daemon_set_v1" "prometheus_ds" {
  metadata {
    name      = "node-directory-size-metrics"
    namespace = var.namespace

    annotations = {
      description = "${file("${path.module}/data/description.txt")}"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "node-directory-size-metrics"
      }
    }

    template {
      metadata {
        labels = {
          app = "node-directory-size-metrics"
        }

        annotations = {
          "prometheus.io/scrape" = "true"
          "prometheus.io/port"   = "9102"
          description            = "${file("${path.module}/data/description.txt")}"
        }
      }

      spec {
        container {
          name  = "read-du"
          image = "giantswarm/tiny-tools"

          image_pull_policy = "Always"
          command           = ["fish", "--command", "${file("${path.module}/data/script.sh")}"]

          volume_mount {
            name       = "host-fs-var"
            mount_path = "/mnt/var"
            read_only  = true
          }

          volume_mount {
            name       = "metrics"
            mount_path = "/tmp"
          }
        }

        container {
          name    = "caddy"
          image   = "dockermuenster/caddy:0.9.3"
          command = ["caddy", "-port=9102", "-root=/var/www"]

          port {
            container_port = 9102
          }

          volume_mount {
            name       = "metrics"
            mount_path = "/var/www"
          }
        }

        volume {
          name = "host-fs-var"
          host_path {
            path = "/var"
          }
        }

        volume {
          name = "metrics"
          empty_dir {
            medium = "Memory"
          }
        }
      }
    }
  }
}
