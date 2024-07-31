resource "kubernetes_service" "queue_master_service" {
  metadata {
    name      = "queue-master"
    namespace = var.namespace

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "queue-master"
    }
  }

  spec {
    port {
      port        = 80
      target_port = 80
    }

    selector = {
      name = var.queue_master_deployment_labels["name"]
    }
  }
}
