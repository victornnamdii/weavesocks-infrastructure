resource "kubernetes_service" "kube_state_service" {
  metadata {
    name      = "kube-state-metrics"
    namespace = var.namespace
    labels    = kubernetes_deployment.kube_state.metadata[0].labels
  }

  spec {
    cluster_ip = "None"

    selector = {
      "app.kubernetes.io/name" = kubernetes_deployment.kube_state.metadata[0].labels["app.kubernetes.io/name"]
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
