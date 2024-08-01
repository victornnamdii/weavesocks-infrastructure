resource "kubernetes_service" "grafana_service" {
  metadata {
    name      = "grafana"
    namespace = var.namespace

    labels = var.grafana_dep_labels
  }

  spec {
    type = "NodePort"

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 3000
      node_port   = 31300
    }

    selector = var.grafana_dep_labels
  }
}
