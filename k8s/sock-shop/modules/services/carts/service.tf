resource "kubernetes_service" "carts_service" {
  metadata {
    name = "carts"

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "carts"
    }

    namespace = var.namespace
  }

  spec {
    port {
      port        = 80
      target_port = 80
    }

    selector = {
      name = kubernetes_deployment.carts_deployment.metadata[0].labels["name"]
    }
  }
}
