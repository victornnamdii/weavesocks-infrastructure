resource "kubernetes_service" "session_db_service" {
  metadata {
    name      = "session-db"
    namespace = var.namespace

    labels = {
      name = "session-db"
    }
  }

  spec {
    port {
      port        = 6379
      target_port = 6379
    }

    selector = {
      name = var.session_db_deployment_labels["name"]
    }
  }
}
