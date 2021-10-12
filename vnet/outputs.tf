output "vnet_data" {
    value = azurerm_virtual_network.vnets
}

output "vnet_subnets" {
    value = local.subnets_two
}