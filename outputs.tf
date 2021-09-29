# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "package" {
  description = "All 'cloudflare_waf_package' resource attributes."
  value       = try(cloudflare_waf_package.package[0], null)
}

output "groups" {
  description = "All 'cloudflare_waf_group' resource attributes."
  value       = try(cloudflare_waf_group.groups, {})
}

output "rules" {
  description = "All 'cloudflare_waf_rule' resource attributes."
  value       = try(cloudflare_waf_rule.rules, {})
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether the module is enabled."
  value       = var.module_enabled
}
