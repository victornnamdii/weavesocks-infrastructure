variable "namespace" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "grafana_configmap_name" {
  type = string
}

variable "prometheus_configmap_name" {
  type = string
}

variable "gf_security_admin_user" {
  type = string
  sensitive = true
}

variable "gf_security_admin_password" {
  type = string
  sensitive = true
}