resource "kubernetes_config_map" "prometheus_cm" {
  metadata {
    name      = "prometheus-configmap"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  data = {
    "prometheus.yml" = "${file("${path.module}/data/prometheus.yml")}"
  }
}
