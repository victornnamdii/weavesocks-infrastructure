resource "kubernetes_deployment" "catalogue_db_deployment" {
  metadata {
    name = "catalogue-db"

    labels = {
      name = "catalogue-db"
    }

    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        name = "catalogue-db"
      }
    }

    template {
      metadata {
        labels = {
          name = "catalogue-db"
        }
      }

      spec {
        container {
          name  = "catalogue-db"
          image = "weaveworksdemos/catalogue-db:0.3.0"

          env {
            name = "MYSQL_ROOT_PASSWORD"

            value_from {
              secret_key_ref {
                name = var.secret_name
                key  = "mysql_password"
              }
            }
          }

          env {
            name = "MYSQL_DATABASE"

            value_from {
              secret_key_ref {
                name = var.secret_name
                key  = "mysql_db"
              }
            }
          }

          port {
            name           = "mysql"
            container_port = 3306
          }
        }

        node_selector = {
          "beta.kubernetes.io/os" = "linux"
        }
      }
    }
  }
}
