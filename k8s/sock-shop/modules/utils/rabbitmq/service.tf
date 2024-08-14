resource "kubernetes_service" "rabbitmq_service" {
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace

    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port"   = "9090"
    }

    labels = kubernetes_deployment.rabbitmq_deployment.metadata[0].labels
  }

  spec {
    port {
      port        = 5672
      name        = "rabbitmq"
      target_port = 5672
    }

    port {
      port        = 9090
      name        = "exporter"
      target_port = "exporter"
      protocol    = "TCP"
    }

    selector = kubernetes_deployment.rabbitmq_deployment.metadata[0].labels
  }
}
