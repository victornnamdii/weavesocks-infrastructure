resource "kubernetes_service" "orders_db_service" {
  metadata {
    name = "orders-db"

    labels = {
      name = "orders-db"
    }

    namespace = var.namespace
  }

  spec {
    port {
      port        = 27017
      target_port = 27017
    }

    selector = {
      name = kubernetes_deployment.orders_db_deployment.metadata[0].labels["name"]
    }
  }
}
