output "kube_state_dep_labels" {
  value = kubernetes_deployment.kube_state.metadata[0].labels
}
