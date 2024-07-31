output "secret_name" {
  value = kubernetes_secret.sock_shop_secret.metadata[0].name
}