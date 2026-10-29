variable "prefix" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "address_space" { type = string; default = "10.0.0.0/16" }
variable "aks_subnet_prefix" { type = string; default = "10.0.1.0/24" }
variable "app_subnet_prefix" { type = string; default = "10.0.2.0/24" }
variable "data_subnet_prefix" { type = string; default = "10.0.3.0/24" }
variable "tags" { type = map(string); default = {} }
