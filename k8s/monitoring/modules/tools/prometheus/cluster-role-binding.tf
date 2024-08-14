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
    name      = kubernetes_cluster_role.prometheus_cr.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.prometheus_sa.metadata[0].name
    namespace = var.namespace
  }
}
