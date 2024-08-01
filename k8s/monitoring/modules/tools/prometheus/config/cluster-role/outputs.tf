output "prometheus_cr_name" {
  value = kubernetes_cluster_role.prometheus_cr.metadata[0].name
}