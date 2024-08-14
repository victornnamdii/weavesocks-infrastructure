resource "kubernetes_service" "grafana_service" {
  metadata {
    name      = "grafana"
    namespace = var.namespace

    labels = kubernetes_deployment.grafana.metadata[0].labels
  }

  spec {
    type = "NodePort"

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 3000
      node_port   = 31300
    }

    selector = kubernetes_deployment.grafana.metadata[0].labels
  }
}
