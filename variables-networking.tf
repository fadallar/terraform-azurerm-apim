variable "ddos_protection_mode" {
  description = "The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited."
  type        = string
  default     = "VirtualNetworkInherited"
  validation {
    condition     = contains(["Disabled", "Enabled", "VirtualNetworkInherited"], var.ddos_protection_mode)
    error_message = "Invalid variable: ${var.ddos_protection_mode}. DDoS protectin mode is not valid we only Disabled, Enabled, and VirtualNetworkInherited"
  }
}

variable "ddos_protection_plan_id" {
  description = "The ID of the DDOS protection plan only rrequired if DDOS protection mode is Enabled"
  type        = string
  default     = null
}

variable "idle_timeout_in_minutes" {
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = null
}

variable "nsg_name" {
  type        = string
  description = "NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private"
  default     = null
}

variable "nsg_rg_name" {
  type        = string
  description = "Name of the RG hosting the NSG if it's different from the one hosting the APIM"
  default     = null
}

variable "create_management_rule" {
  type        = bool
  description = "Whether to create the NSG rule for the management port of the APIM. If true, nsg_name variable must be set"
  default     = false
}

variable "management_nsg_rule_priority" {
  type        = number
  description = "Priority of the NSG rule created for the management port of the APIM"
  default     = 101
}