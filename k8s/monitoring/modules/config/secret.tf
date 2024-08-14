resource "kubernetes_secret" "monitoring_secret" {
  metadata {
    name      = "sockshop-secret"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  type = "Opaque"
  data = {
    gf_security_admin_user = var.gf_security_admin_user
    gf_security_admin_password = var.gf_security_admin_password
  }
}
