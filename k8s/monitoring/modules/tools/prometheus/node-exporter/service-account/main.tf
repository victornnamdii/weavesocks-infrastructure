resource "kubernetes_service_account" "prometheus_node_exporter_sa" {
  metadata {
    name = "node-exporter"
    namespace = var.namespace

    labels = {
      "app.kubernetes.io/component" = "exporter"
      "app.kubernetes.io/name"      = "node-exporter"
    }
  }
}
