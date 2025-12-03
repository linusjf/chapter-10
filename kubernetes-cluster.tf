#
# Creates a managed Kubernetes cluster on Azure.
#
resource "azurerm_kubernetes_cluster" "cluster" {
  name                = local.app_name
  location            = var.location
  resource_group_name = azurerm_resource_group.flixtube.name
  dns_prefix          = local.app_name
  kubernetes_version  = var.kubernetes_version

  role_based_access_control_enabled = true

  default_node_pool {
    name                  = "default"
    auto_scaling_enabled  = true
    min_count             = 1
    max_count             = 20
    node_count            = var.node_count
    vm_size               = var.vm_size
  }

  #
  # Instead of creating a service principle have the system figure this out.
  #
  identity {
    type = "SystemAssigned"
  }

}

#
# Attaches the container registry to the cluster.
# See example here: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage-attaching-a-container-registry-to-a-kubernetes-cluster
#
resource "azurerm_role_assignment" "role_assignment" {
  principal_id                     = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.container_registry.id
  skip_service_principal_aad_check = true
}
