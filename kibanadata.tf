data "kubernetes_secret" "es_password" {
  count = var.deploy_efk ? 1 : 0

  metadata {
    name      = "elasticsearch-master-credentials"
    namespace = kubernetes_namespace.logging[0].metadata[0].name
  }

  depends_on = [helm_release.elasticsearch]
}

locals {
  es_password = var.deploy_efk ? base64decode(data.kubernetes_secret.es_password[0].data["password"]) : null
}
