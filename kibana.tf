resource "helm_release" "kibana" {
  count      = var.deploy_efk ? 1 : 0
  name       = "kibana"
  namespace  = kubernetes_namespace.logging[0].metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kibana"
  version    = "10.8.3"

  depends_on = [helm_release.elasticsearch]

  set = [
    {
      name  = "elasticsearch.hosts[0]"
      value = "elasticsearch-master"
    },
    {
      name  = "elasticsearch.security.enabled"
      value = "true"
    },
    {
      name  = "elasticsearch.security.elasticsearchPassword"
      value = local.es_password
    },
    {
      name  = "elasticsearch.tls.enabled"
      value = "true"
    }
  ]
}
