variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region to use."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "publisher_name" {
  description = ""
  type        = string
}

variable "publisher_email" {
  description = ""
  type        = string
}

variable "sku_type" {
  description = "SKU Type valid values include: Consumption, Developer, Basic, Standard and Premium"
  type        = string
  default     = "Developer"
}

variable "sku_capacity" {
  description = "The number of deployed units of the sku"
  type        = number
  default     = 1
}

variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be configured on this API Management Service. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of User Assigned Managed Identity IDs to be assigned to this API Management Service."
  type        = list(string)
  default     = null
}

variable "public_ip_address_id" {
  description = "ID of a standard SKU IPv4 Public IP."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Is public access to the service allowed?. Defaults to true"
  type        = bool
  default     = true
}

variable "virtual_network_type" {
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
  type        = string
  default     = "None"
}

variable "zones" {
  description = "Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created."
  type        = list(string)
  default     = []
}

variable "apim_subnet_id" {
  description = "Subnet Id of the APIM subnet. Used if virtual network type is internal or external"
  type        = string
  default     = null
}

variable "app_insights_id" {
  description = "Id of the Application Insights used by the APIM Logger"
  type        = string
  default     = null
}

variable "app_insigths_instrumentation_key" {
  description = "Instrumentation Key of the Application insights"
  type        = string
  default     = null
}