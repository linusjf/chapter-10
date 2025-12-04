output "elasticsearch_password" {
  value     = local.es_password
  sensitive = true
  description = "Password for the elastic user"
}

output "kibana_access" {
  value = var.deploy_efk ? "Run: kubectl port-forward -n logging svc/kibana 5601:5601" : null
}
