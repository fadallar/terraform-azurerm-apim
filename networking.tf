resource "azurerm_public_ip" "this" {
  name                    = format("pip-%s", local.name)
  resource_group_name     = var.resource_group_name
  location                = var.location
  allocation_method       = "Static"
  zones                   = var.zones
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  domain_name_label       = local.name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  tags                    = merge(var.default_tags, var.extra_tags)
}











