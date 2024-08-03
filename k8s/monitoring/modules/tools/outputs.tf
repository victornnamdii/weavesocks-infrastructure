output "prometheus_svc_name" {
  value = module.prometheus.prometheus_svc_name
}

output "prometheus_svc_port" {
  value = module.prometheus.prometheus_svc_port
}

output "grafana_svc_name" {
  value = module.grafana.grafana_svc_name
}

output "grafana_svc_port" {
  value = module.grafana.grafana_svc_port
}
