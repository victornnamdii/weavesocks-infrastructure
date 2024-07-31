resource "kubernetes_service" "user_db_service" {
  metadata {
    name = "user-db"

    labels = {
      name = "user-db"
    }

    namespace = var.namespace
  }

  spec {
    port {
      port        = 27017
      target_port = 27017
    }

    selector = {
      name = var.user_db_deployment_labels["name"]
    }
  }
}
