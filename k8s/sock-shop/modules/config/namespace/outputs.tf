output "namespace_name" {
  value = kubernetes_namespace.sock-shop.metadata[0].name
}
