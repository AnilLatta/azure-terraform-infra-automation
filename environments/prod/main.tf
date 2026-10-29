terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-enterprise-${var.environment}-rg"
  location = var.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "InfrastructureAutomation"
    Owner       = "Anil Kumar"
  }
}

module "vnet" {
  source              = "../../modules/vnet"
  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = "10.100.0.0/16"
  aks_subnet_prefix   = "10.100.1.0/24"
  app_subnet_prefix   = "10.100.2.0/24"
  data_subnet_prefix  = "10.100.3.0/24"
  tags                = azurerm_resource_group.rg.tags
}

module "aks" {
  source              = "../../modules/aks"
  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_subnet_id      = module.vnet.aks_subnet_id
  system_node_count   = 3
  tags                = azurerm_resource_group.rg.tags
}

module "keyvault" {
  source              = "../../modules/keyvault"
  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags
}

module "storage" {
  source              = "../../modules/storage"
  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags
}

module "database" {
  source              = "../../modules/database"
  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags
}
