resource "kubernetes_namespace" "sock-shop" {
  metadata {
    name = "sock-shop"
  }
}
