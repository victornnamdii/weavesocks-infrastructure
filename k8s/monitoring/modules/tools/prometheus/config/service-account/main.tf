resource "kubernetes_service_account_v1" "prometheus_sa" {
  metadata {
    name      = "prometheus"
    namespace = var.namespace
    labels = {
      app = "prometheus"
    }
  }
}
