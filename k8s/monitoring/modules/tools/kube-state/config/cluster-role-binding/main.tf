resource "kubernetes_cluster_role_binding_v1" "kube_state_cb" {
  metadata {
    name = "kube-state-metrics"
    labels = {
      name = "kube-state-metrics"
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
