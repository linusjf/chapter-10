resource "kubernetes_namespace" "logging" {
  count = var.deploy_efk ? 1 : 0

  metadata {
    name = "logging"
  }
}
