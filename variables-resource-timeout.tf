variable "create-timeout" {
  description = "Resource creation timeout"
  type        = string
  default     = "90m"

}
variable "delete-timeout" {
  description = "Resource deletion timeout"
  type        = string
  default     = "90m"

}

variable "update-timeout" {
  description = "Resource update timeout"
  type        = string
  default     = "90m"
}