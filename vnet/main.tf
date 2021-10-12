provider "azurerm" {
  features {}
}

/*
This deploys vnets
*/

resource "azurerm_virtual_network" "vnets" {
  for_each            = var.vnets
  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  dns_servers = each.value["dns_servers"] != null ? each.value["dns_servers"] : null
  address_space       = each.value["address_space"]
  // dns_servers         = each.value["vnetservers"]
  
  dynamic "subnet" {
    for_each = each.value["subnets"]
    content {
      name           = subnet.value["name"]
      address_prefix = subnet.value["address_prefix"]
    }
    /*
  subnet {
    for_each       = var.subnets
    name           = each.value["subname"] //"bcsubnet1"
    address_prefix = each.value["subaddr"] //"10.0.1.0/24"
  }
  */
  }
}

locals {
  subnets = {for k, v in azurerm_virtual_network.vnets: "subnets-${k}" => v.subnet}
  subnets_two = {for k, v in local.subnets: "sub-ids-${k}" => {
    for value in v: "id-data-${value.name}" => value.id
  }}
}