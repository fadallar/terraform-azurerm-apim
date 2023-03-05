###### Public IP
output "public_ip_id" {
  description = "The ID of this Public IP."
  value       = azurerm_public_ip.this.id
}

output "public_ip_address" {
  description = "The IP address value that was allocated."
  value       = azurerm_public_ip.this.ip_address
}

output "public_ip_fqdn" {
  description = "The Public IP FQDN"
  valure      = azurerm_public_ip.this.fqdn
}

########## API Management

output "id" {
  description = "The ID of the API Management Service."
  value       = azure_api_management.id
}

output "gateway_url" {
  description = "The URL of the Gateway for the API Management Service."
  value       = azure_api_management.gateway_url
}

output "gateway_regional_url" {
  description = " - The Region URL for the Gateway of the API Management Service."
  value       = azure_api_management.gateway_regional_url
}

output "identity" {
  description = "An identity block"
  value       = azure_api_management.identity
}

output "hostname_configuration" {
  description = " A hostname_configuration block"
  value       = azure_api_management.hostname_configuration
}

output "management_api_url" {
  description = "The URL for the Management API associated with this API Management service."
  value       = azure_api_management.management_api_url
}

output "portal_url" {
  description = "The URL for the Publisher Portal associated with this API Management service."
  value       = azure_api_management.portal_url
}
output "developer_portal_url" {
  description = "The URL for the Developer Portal associated with this API Management service."
  value       = azure_api_management.developer_portal_url
}

output "public_ip_addresses" {
  description = "The Public IP addresses of the API Management Service."
  value       = azure_api_management.public_ip_addresses
}

output "private_ip_addresses" {
  description = "The Private IP addresses of the API Management Service."
  value       = azure_api_management.private_ip_addresses
}

output "scm_url" {
  description = "The URL for the SCM (Source Code Management) Endpoint associated with this API Management service."
  value       = azure_api_management.scm_url
}

output "tenant_access" {
  description = "The tenant_access block"
  value       = azure_api_management.tenant_access
}
