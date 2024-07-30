resource "kubernetes_service" "user_service" {
  metadata {
    name = "user"

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "user"
    }

    namespace = var.namespace
  }

  spec {
    port {
      port        = 80
      target_port = 80
    }

    selector = {
      name = var.user_deployment_labels["name"]
    }
  }
}
