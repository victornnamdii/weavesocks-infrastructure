resource "kubernetes_service" "shipping_service" {
  metadata {
    name = "shipping"

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "shipping"
    }

    namespace = var.namespace
  }

  spec {
    port {
      port        = 80
      target_port = 80
    }

    selector = {
      name = kubernetes_deployment.shipping_deployment.metadata[0].labels["name"]
    }
  }
}
