output "secret_name" {
  value = kubernetes_secret.sock_shop_secret.metadata[0].name
}

output "configmap_name" {
  value = kubernetes_config_map.sock_shop_config.metadata[0].name
}

output "namespace" {
  value = kubernetes_namespace.sock-shop.metadata[0].name
}
