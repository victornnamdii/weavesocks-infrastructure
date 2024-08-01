module "import_dash_batch" {
  source = "./import-dash-batch"
  namespace = var.namespace
  grafana_configmap_name = var.grafana_configmap_name
}