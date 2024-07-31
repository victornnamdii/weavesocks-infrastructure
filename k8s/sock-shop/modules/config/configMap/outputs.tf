output "configmap_name" {
  value = kubernetes_config_map.sock_shop_config.metadata[0].name
}