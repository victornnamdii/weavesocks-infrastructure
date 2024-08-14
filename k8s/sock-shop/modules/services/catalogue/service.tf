resource "kubernetes_service" "catalogue_service" {
  metadata {
    name      = "catalogue"
    namespace = var.namespace

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "catalogue"
    }
  }

  spec {
    port {
      port        = 80
      target_port = 80
    }

    selector = {
      name = kubernetes_deployment.catalogue_deployment.metadata[0].labels["name"]
    }
  }
}
