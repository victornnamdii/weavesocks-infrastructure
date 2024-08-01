resource "kubernetes_config_map" "prometheus_alertrules_cm" {
  metadata {
    name      = "prometheus-alertrules"
    namespace = var.namespace
  }

  data = {
    "alert.rules" = "${file("${path.module}/data/alert.rules.yml")}"
  }
}
