resource "kubernetes_cluster_role_binding" "kube_state_crb" {
  metadata {
    name = "kube-state-metrics"
    labels = {
      "app.kubernetes.io/name"    = "kube-state-metrics"
      "app.kubernetes.io/version" = "2.1.0"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.kube_state_cr.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.kube_state_sa.metadata[0].name
    namespace = var.namespace
  }
}
