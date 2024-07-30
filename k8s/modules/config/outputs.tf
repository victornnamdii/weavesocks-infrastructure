output "secret_name" {
  value = module.secret.secret_name
}

output "configmap_name" {
  value = module.configMap.configmap_name
}

output "namespace" {
  value = module.namespace.namespace_name
}
