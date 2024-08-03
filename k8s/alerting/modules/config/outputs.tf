output "secret_name" {
  value = module.secret.alertmanager_secret_name
}

output "configmap_name" {
  value = module.configmap.alertmanager_configmap_name
}