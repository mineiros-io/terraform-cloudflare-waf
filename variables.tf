# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "zone_id" {
  description = "(Required) The DNS zone ID to apply to."
  type        = string
}

variable "package_id" {
  description = "(Required) The WAF Package ID."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "sensitivity" {
  description = "(Optional) The sensitivity of the package, can be one of ['high', 'medium', 'low', 'off']."
  type        = string
  default     = null

  validation {
    condition     = var.sensitivity == null ? true : contains(["high", "medium", "low", "off"], var.sensitivity)
    error_message = "The value must only be one of these valid values: high, medium, low, off."
  }
}

variable "action_mode" {
  description = "(Optional) The action mode of the package, can be one of ['block', 'challenge', 'simulate']."
  type        = string
  default     = null

  validation {
    condition     = var.action_mode == null ? true : contains(["block", "challenge", "simulate"], var.action_mode)
    error_message = "The value must only be one of these valid values: block, challenge, simulate."
  }
}

variable "groups" {
  description = "(Optional) A list of WAF groups."
  type        = any
  default     = []

  validation {
    condition     = alltrue([for x in var.groups : can(x.group_id)])
    error_message = "All groups sets must have a defined group id."
  }

  validation {
    condition     = alltrue([for x in var.groups : contains(["on", "off"], x.mode)])
    error_message = "All groups sets must have a defined mode with valid values: on, off."
  }
}

variable "rules" {
  description = "(Optional) A list of WAF rules."
  type        = any
  default     = []

  validation {
    condition     = alltrue([for x in var.rules : can(x.rule_id)])
    error_message = "All rules sets must have a defined rule id."
  }

  validation {
    condition     = alltrue([for x in var.rules : contains(["block", "challenge", "default", "disable", "simulate", "on", "off"], x.mode)])
    error_message = "All rules sets must have a defined mode with valid values: block, challenge, default, disable, simulate, on, off."
  }
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}
