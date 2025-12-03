data "kubernetes_namespace" "test" {
  metadata {
    name = "default"
  }
}
