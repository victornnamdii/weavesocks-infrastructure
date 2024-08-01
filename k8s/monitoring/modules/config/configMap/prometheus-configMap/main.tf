resource "kubernetes_config_map" "prometheus_cm" {
  metadata {
    name = "prometheus-configmap"
    namespace = var.namespace
  }

  data = {
    "prometheus.yml" = "${file("${path.module}/data/prometheus.yml")}"
  }
}