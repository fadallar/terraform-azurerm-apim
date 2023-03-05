variable "ddos_protection_mode" {
  description = "The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited."
  type        = string
  default     = "VirtualNetworkInherited"
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

variable "create_apim_subnet" {
  description = "Boolean if set to true a new subnet will be created. Otherwise a subnet id should be provided if VNET integration mode is internal or external"
  type        = Boolean
  default     = true
}