resource "kubernetes_service_account_v1" "kube_state_sa" {
  metadata {
    name      = "kube-state-metrics"
    namespace = var.namespace

    labels = {
      "app.kubernetes.io/name"    = "kube-state-metrics"
      "app.kubernetes.io/version" = "2.1.0"
    }
  }
}
