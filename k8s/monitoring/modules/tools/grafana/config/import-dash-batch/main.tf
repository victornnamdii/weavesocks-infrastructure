resource "kubernetes_secret" "script_secret" {
  metadata {
    name = "script-secret"
    namespace = var.namespace
  }

  data = {
    "script.sh" = <<-EOT
      for file in *-datasource.json ; do
          if [ -e "$file" ] ; then
              echo "importing $file" &&
              curl --silent --fail --show-error \
              --request POST http://${var.gf_security_admin_user}:${var.gf_security_admin_password}@grafana/api/datasources \
              --header "Content-Type: application/json" \
              --header "Accept: application/json" \
              --data-binary "@$file" ;
              echo "" ;
          fi
      done ;
      for file in *-dashboard.json ; do
          if [ -e "$file" ] ; then
              echo "importing $file" &&
              curl --silent --fail --show-error \
              --request POST http://${var.gf_security_admin_user}:${var.gf_security_admin_password}@grafana/api/dashboards/import \
              --header "Content-Type: application/json" \
              --header "Accept: application/json" \
              --data-binary "@$file" ;
              echo "" ;
          fi
      done ;
    EOT
  }
}

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
          args = [
            "sh /scripts/script.sh"
          ]

          volume_mount {
            name       = "config-volume"
            mount_path = "/opt/grafana-import-dashboards"
          }

          volume_mount {
            name       = "script-volume"
            mount_path = "/scripts"
          }
        }

        restart_policy = "Never"

        volume {
          name = "config-volume"

          config_map {
            name = var.grafana_configmap_name
          }
        }

        volume {
          name = "script-volume"

          secret {
            secret_name = kubernetes_secret.script_secret.metadata[0].name
          }
        }
      }
    }
  }

  depends_on = [kubernetes_secret.script_secret]
}
