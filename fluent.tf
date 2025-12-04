resource "helm_release" "fluentbit" {
  count      = var.deploy_efk ? 1 : 0
  name       = "fluent-bit"
  namespace  = kubernetes_namespace.logging[0].metadata[0].name
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "0.54.0"  # or a recent version available from fluent/helm-charts
  set = [
    {
      name  = "backend.type"
      value = "es"
    },
    {
      name  = "backend.es.host"
      value = "elasticsearch-master"
    },
    {
      name  = "backend.es.tls"
      value = "on"
    }
  ]
}
