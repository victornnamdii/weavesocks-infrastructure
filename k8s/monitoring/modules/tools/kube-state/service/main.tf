resource "kubernetes_service" "kube_state_service" {
  metadata {
    name      = "kube-state-metrics"
    namespace = var.namespace
    labels = var.kube_state_dep_labels
  }

  spec {
    cluster_ip = "None"

    selector = {
      "app.kubernetes.io/name" = var.kube_state_dep_labels["app.kubernetes.io/name"]
    }

    port {
      name        = "http-metrics"
      port        = 8080
      target_port = "http-metrics"
    }

    port {
      name        = "telemetry"
      port        = 8081
      target_port = "telemetry"
    }
  }
}
