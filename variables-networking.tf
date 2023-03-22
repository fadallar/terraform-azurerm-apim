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