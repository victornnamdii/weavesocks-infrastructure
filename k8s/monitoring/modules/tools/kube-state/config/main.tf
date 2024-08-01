module "kube_state_cluster_role" {
  source = "./cluster-role"
}

module "kube_state_cluster_role_binding" {
  source                          = "./cluster-role-binding"
  namespace                       = var.namespace
  kube_state_cr_name              = module.kube_state_cluster_role.kube_state_cr_name
  kube_state_service_account_name = module.kube_state_service_account.kube_state_service_account_name
}

module "kube_state_service_account" {
  source    = "./service-account"
  namespace = var.namespace
}
