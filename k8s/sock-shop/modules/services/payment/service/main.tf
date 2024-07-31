resource "kubernetes_service" "payment_service" {
  metadata {
    name = "payment"
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
      port = 80
      target_port = 80
    }

    selector = {
      name = var.payment_deployment_labels["name"]
    }
  }
}