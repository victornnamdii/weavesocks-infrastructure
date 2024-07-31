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
      name = var.carts_deployment_labels["name"]
    }
  }
}
