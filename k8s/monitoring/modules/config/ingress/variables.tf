variable "namespace" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "prometheus_svc_name" {
  type = string
}

variable "prometheus_svc_port" {
  type = number
}

variable "grafana_svc_name" {
  type = string
}

variable "grafana_svc_port" {
  type = number
}