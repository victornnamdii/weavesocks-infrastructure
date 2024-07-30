resource "kubernetes_service" "catalogue_db_service" {
  metadata {
    name = "catalogue-db"

    labels = {
      name = "catalogue-db"
    }

    namespace = var.namespace
  }

  spec {
    port {
      port = 3306
      target_port = 3306
    }

    selector = {
      name = var.catalogue_db_deployment_labels["name"]
    }
  }
}