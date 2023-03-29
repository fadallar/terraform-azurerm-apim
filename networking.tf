resource "azurerm_public_ip" "this" {
  count                   = var.virtual_network_type != "None" ? 1 : 0
  name                    = format("pip-%s", local.name)
  resource_group_name     = var.resource_group_name
  location                = var.location
  allocation_method       = "Static"
  sku                     = "Standard"
  zones                   = var.zones
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  domain_name_label       = format("pip-%s", local.name)
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  tags                    = merge(var.default_tags, var.extra_tags)
}

####  NSG Rule required to allow apim management
resource "azurerm_network_security_rule" "management_apim" {
  count                       = var.create_management_rule ? 1 : 0
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "AllowAPIMManagementEndpoint"
  network_security_group_name = var.nsg_name
  priority                    = var.management_nsg_rule_priority
  protocol                    = "Tcp"
  resource_group_name         = var.nsg_rg_name == null ? var.resource_group_name : var.nsg_rg_name

  source_port_range          = "*"
  destination_port_range     = "3443"
  source_address_prefix      = "ApiManagement"
  destination_address_prefix = "VirtualNetwork"
}
