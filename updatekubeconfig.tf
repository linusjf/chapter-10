resource "null_resource" "update_kubeconfig" {
  triggers = {
    host = azurerm_kubernetes_cluster.cluster.kube_config.0.host
  }
  provisioner "local-exec" {
    command = <<EOF
az aks get-credentials \
  --resource-group ${azurerm_resource_group.flixtube.name} \
  --name ${azurerm_kubernetes_cluster.cluster.name} \
  --admin --overwrite-existing
EOF
  }
}
