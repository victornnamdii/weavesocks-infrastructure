output "kube_state_service_account_name" {
  value = kubernetes_service_account.kube_state_sa.metadata[0].name
}