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
    selector = kubernetes_deployment.prometheus.spec[0].selector[0].match_labels

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
