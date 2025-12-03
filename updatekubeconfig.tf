resource "null_resource" "update_kubeconfig" {
  triggers = {
    cluster_id = azurerm_kubernetes_cluster.cluster.id
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
