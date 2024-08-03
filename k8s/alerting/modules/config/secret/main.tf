resource "kubernetes_secret" "alertmanager_secret" {
  metadata {
    name = "slack-hook-url"
  }

  type = "Opaque"

  data = {
    "slack-hook-url" = var.slack_hook_url
  }
}