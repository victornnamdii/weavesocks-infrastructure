resource "kubernetes_cluster_role_v1" "prometheus_cr" {
  metadata {
    name = "prometheus"
    labels = {
      app = "prometheus"
    }
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "nodes/metrics", "node/proxy", "services", "endpoints", "pods"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    non_resource_urls = ["/metrics"]
    verbs             = ["get"]
  }
}
