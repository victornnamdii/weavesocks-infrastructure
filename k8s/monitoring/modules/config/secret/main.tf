resource "kubernetes_secret" "monitoring_secret" {
  metadata {
    name      = "sockshop-secret"
    namespace = var.namespace
  }
  type = "Opaque"
  data = {
    gf_security_admin_user = var.gf_security_admin_user
    gf_security_admin_password = var.gf_security_admin_password
  }
}
