output "kube_state_cr_name" {
  value = kubernetes_cluster_role.kube_state_cr.metadata[0].name
}