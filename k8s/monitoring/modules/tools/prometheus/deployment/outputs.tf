output "prometheus_dep_labels" {
  value = kubernetes_deployment.prometheus.spec[0].selector[0].match_labels
}
