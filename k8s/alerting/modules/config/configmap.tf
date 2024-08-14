resource "kubernetes_config_map" "alertmanager_configmap" {
  metadata {
    name = "alertmanager"
  }

  data = {
    "config.yml"          = "${file("${path.module}/data/config.yml")}"
    "configure_secret.sh" = "${file("${path.module}/data/configure_secret.sh")}"
  }
}
