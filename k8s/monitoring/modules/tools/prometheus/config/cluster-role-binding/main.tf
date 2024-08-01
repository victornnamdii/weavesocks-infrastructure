resource "kubernetes_cluster_role_binding" "prometheus_cb" {
  metadata {
    name = "prometheus"
    labels = {
      app = "prometheus"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.prometheus_cr_name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.prometheus_service_account_name
    namespace = var.namespace
  }
}
