resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.prefix}-k8s-${var.environment}"
  kubernetes_version  = var.k8s_version

  default_node_pool {
    name                = "systempool"
    node_count          = var.system_node_count
    vm_size             = var.node_vm_size
    vnet_subnet_id      = var.vnet_subnet_id
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "userpool" {
  name                  = "userworkload"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.user_node_vm_size
  enable_auto_scaling   = true
  min_count             = 2
  max_count             = 10
  vnet_subnet_id        = var.vnet_subnet_id

  tags = var.tags
}
