variable "mysql_db" {
  type = string
  sensitive = true
}

variable "mysql_password" {
  type = string
  sensitive = true
}

variable "java_opts" {
  type = string
}

variable "user_db" {
  type = string
}

variable "zipkin" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "session_redis" {
  type = string
}

variable "gf_security_admin_password" {
  type = string
  sensitive = true
}

variable "gf_security_admin_user" {
  type = string
  sensitive = true
}

variable "slack_hook_url" {
  type = string
  sensitive = true
}

variable "cluster_name" {
  type = string
}

variable "certificate_email" {
  type = string
  sensitive = true
}
