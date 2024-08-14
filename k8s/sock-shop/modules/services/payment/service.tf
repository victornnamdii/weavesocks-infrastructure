resource "kubernetes_service" "payment_service" {
  metadata {
    name      = "payment"
    namespace = var.namespace

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "payment"
    }
  }

  spec {
    port {
      port        = 80
      target_port = 80
    }

    selector = {
      name = kubernetes_deployment.payment_deployment.metadata[0].labels["name"]
    }
  }
}
