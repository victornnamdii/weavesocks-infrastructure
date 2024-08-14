resource "kubernetes_config_map" "grafana_cm" {
  metadata {
    name      = "grafana-import-dashboards"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  data = {
    "prometheus-stats-dashboard.json" = "${file("${path.module}/data/prometheus-stats-dashboard.json")}"
    "k8s-pod-resources-dashboard.json" = "${file("${path.module}/data/k8s-pod-resources-dashboard.json")}"
    "sock-shop-resources-dashboard.json" = "${file("${path.module}/data/sock-shop-resources-dashboard.json")}"
    "sock-shop-performance-dashboard.json" = "${file("${path.module}/data/sock-shop-performance-dashboard.json")}"
    "sock-shop-analytics-dashboard.json" = "${file("${path.module}/data/sock-shop-analytics-dashboard.json")}"
    "prometheus-datasource.json" = "${file("${path.module}/data/prometheus-datasource.json")}"
    "prometheus-node-exporter-dashboard.json" = "${file("${path.module}/data/prometheus-node-exporter-dashboard.json")}"
  }
}
