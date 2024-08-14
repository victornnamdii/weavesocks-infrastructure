resource "kubernetes_service" "frontend_service" {
  metadata {
    name      = "front-end"
    namespace = var.namespace

    annotations = {
      "prometheus.io/scrape" = "true"
    }

    labels = {
      name = "front-end"
    }
  }

  spec {
    type = "NodePort"

    port {
      port        = 80
      target_port = 8079
      node_port   = 30001
    }

    selector = {
      name = kubernetes_deployment.frontend_deployment.spec[0].selector[0].match_labels["name"]
    }
  }
}
