resource "kubernetes_service" "prometheus_node_exporter_svc" {
  metadata {
    name      = "node-exporter"
    namespace = var.namespace

    labels = {
      "app.kubernetes.io/component" = "exporter"
      "app.kubernetes.io/name"      = "node-exporter"
    }
  }

  spec {
    cluster_ip = "None"

    port {
      name        = "http"
      port        = 9100
      target_port = 9100
    }

    selector = {
      "app.kubernetes.io/component" = "exporter"
      "app.kubernetes.io/name"      = "node-exporter"
    }
  }
}
