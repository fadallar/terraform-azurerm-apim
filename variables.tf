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
  validation {
    condition     = var.stack == "" || can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.stack))
    error_message = "Invalid variable: ${var.stack}. Variable name must start with a lowercase letter, end with an alphanumeric lowercase character, and contain only lowercase letters, digits, or a dash (-)."
  }
}

#### APIM Specific

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
  validation {
    condition     = contains(["Consumption", "Developer", "Basic", "Standard", "Premium"], var.sku_type)
    error_message = "Invalid variable: ${var.sku_type}. SKU Type valid values include: Consumption, Developer, Basic, Standard and Premium"
  }
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
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "Invalid variable: ${var.identity_type}.Identity type possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned"
  }
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
  validation {
    condition     = contains(["None", "External", "Internal"], var.virtual_network_type)
    error_message = "Invalid variable: ${var.virtual_network_type}.Virtual Network Type possible values are None, External, Internal"
  }
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

variable "enable_app_insights" {
  description = "Enable App insight for the APIM Logger"
  type        = bool
  default     = false
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

variable "client_certificate_enabled" {
  description = ""
  type        = bool
  default     = false
}

variable "certificate_configuration" {
  type        = list(map(string))
  description = "List of certificate configurations"
  default     = []
}

variable "enable_http2" {
  type        = bool
  description = "Should HTTP/2 be supported by the API Management Service?"
  default     = false
}

variable "management_hostname_configuration" {
  type        = list(map(string))
  description = "List of management hostname configurations"
  default     = []
}

variable "scm_hostname_configuration" {
  type        = list(map(string))
  description = "List of scm hostname configurations"
  default     = []
}

variable "proxy_hostname_configuration" {
  type        = list(map(string))
  description = "List of proxy hostname configurations"
  default     = []
}

variable "portal_hostname_configuration" {
  type        = list(map(string))
  description = "Legacy portal hostname configurations"
  default     = []
}

variable "developer_portal_hostname_configuration" {
  type        = list(map(string))
  description = "Developer portal hostname configurations"
  default     = []
}

variable "notification_sender_email" {
  type        = string
  description = "Email address from which the notification will be sent"
  default     = null
}

variable "enable_sign_in" {
  type        = bool
  description = "Should anonymous users be redirected to the sign in page?"
  default     = false
}

variable "enable_sign_up" {
  type        = bool
  description = "Can users sign up on the development portal?"
  default     = false
}

variable "terms_of_service_configuration" {
  type        = list(map(string))
  description = "Map of terms of service configuration"

  default = [{
    consent_required = false
    enabled          = false
    text             = ""
  }]
}

variable "ciphers_configuration" {
  type        = map(string)
  description = "Map of security configuration"
  default     = {}
}

variable "policy_configuration" {
  type        = map(string)
  description = "Map of policy configuration"
  default     = {}
}