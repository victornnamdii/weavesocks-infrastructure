resource "kubernetes_job" "grafana_idb" {
  metadata {
    name      = "grafana-import-dashboards"
    namespace = var.namespace

    labels = {
      app       = "grafana"
      component = "import-dashboards"
    }
  }

  spec {
    template {
      metadata {
        name = "grafana-import-dashboards"

        labels = {
          app       = "grafana"
          component = "import-dashboards"
        }

        annotations = {
          "pod.beta.kubernetes.io/init-containers" = "${file("${path.module}/data/init-containers.json")}"
        }
      }

      spec {
        container {
          name        = "grafana-import-dashboards"
          image       = "giantswarm/tiny-tools"
          command     = ["/bin/sh", "-c"]
          working_dir = "/opt/grafana-import-dashboards"
          args        = ["${file("${path.module}/data/script.sh")}"]

          volume_mount {
            name = "config-volume"
            mount_path = "/opt/grafana-import-dashboards"
          }
        }

        restart_policy = "Never"

        volume {
          name = "config-volume"

          config_map {
            name = var.grafana_configmap_name
          }
        }
      }
    }
  }
}
