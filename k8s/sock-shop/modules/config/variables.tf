variable "java_opts" {
  type = string
}

variable "zipkin" {
  type = string
}

variable "frontend_svc_name" {
  type = string
}

variable "frontend_svc_port" {
  type = number
}

variable "domain_name" {
  type = string
}

variable "mysql_db" {
  type = string
}

variable "mysql_password" {
  type = string
}

variable "user_db" {
  type = string
}

variable "session_redis" {
  type = string
}
