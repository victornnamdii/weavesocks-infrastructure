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
    name      = var.kube_state_cr_name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.kube_state_service_account_name
    namespace = var.namespace
  }
}
