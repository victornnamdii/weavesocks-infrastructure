output "prometheus_cr_name" {
  value = kubernetes_cluster_role_v1.prometheus_cr.metadata[0].name
}