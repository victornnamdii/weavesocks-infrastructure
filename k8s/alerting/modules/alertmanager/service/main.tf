resource "kubernetes_service" "alertmanager_svc" {
  metadata {
    name = "alertmanager"

    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/path"   = "/alertmanager/metrics"
    }

    labels = {
      name = "alertmanager"
    }
  }

  spec {
    selector = {
      app = "alertmanager"
    }

    port {
      name        = "alertmanager"
      protocol    = "TCP"
      port        = 9093
      target_port = 9093
    }
  }
}
