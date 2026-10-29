variable "prefix" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "vnet_subnet_id" { type = string }
variable "k8s_version" { type = string; default = "1.28.5" }
variable "system_node_count" { type = number; default = 2 }
variable "node_vm_size" { type = string; default = "Standard_D4s_v5" }
variable "user_node_vm_size" { type = string; default = "Standard_D8s_v5" }
variable "tags" { type = map(string); default = {} }
