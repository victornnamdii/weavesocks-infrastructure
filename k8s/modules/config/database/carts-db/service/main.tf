resource "kubernetes_service" "carts_db_service" {
  metadata {
    name = "carts-db"

    labels = {
      name = "carts-db"
    }

    namespace = var.namespace
  }

  spec {
    port {
      port = 27017
      target_port = 27017
    }

    selector = {
      name = var.carts_db_deployment_labels["name"]
    }
  }
}