output "prometheus_alertrules_configmap_name" {
  value = module.alert_rules.prometheus_alertrules_configmap_name
}

output "prometheus_service_account_name" {
  value = module.prometheus_service_account.prometheus_service_account_name
}

