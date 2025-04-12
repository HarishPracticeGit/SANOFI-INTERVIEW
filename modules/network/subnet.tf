resource "azurerm_subnet" "this" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value = {
    for subnet in azurerm_subnet.this : subnet.name => subnet.id
  }
}