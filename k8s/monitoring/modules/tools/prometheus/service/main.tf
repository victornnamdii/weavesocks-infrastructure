resource "kubernetes_service" "prometheus_service" {
  metadata {
    name      = "prometheus"
    namespace = var.namespace

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "prometheus"
    }
  }

  spec {
    selector = var.prometheus_dep_labels

    type = "NodePort"

    port {
      name        = "prometheus"
      protocol    = "TCP"
      port        = 9090
      target_port = 9090
      node_port   = 31090
    }
  }
}
