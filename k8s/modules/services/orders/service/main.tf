resource "kubernetes_service" "orders_service" {
  metadata {
    name = "orders"
    namespace = var.namespace

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "orders"
    }
  }

  spec {
    port {
      port = 80
      target_port = 80
    }

    selector = {
        name = var.orders_deployment_labels["name"]
    }
  }
}