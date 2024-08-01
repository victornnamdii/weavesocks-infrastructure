output "kube_state_cr_name" {
  value = kubernetes_cluster_role_v1.kube_state_cr.metadata[0].name
}