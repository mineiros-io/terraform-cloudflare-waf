resource "cloudflare_waf_package" "package" {
  count = var.module_enabled ? 1 : 0

  depends_on = [var.module_depends_on]

  zone_id     = var.zone_id
  package_id  = var.package_id
  sensitivity = var.sensitivity
  action_mode = var.action_mode
}

locals {
  groups = { for b in var.groups : b.group_id => b }
}

resource "cloudflare_waf_group" "groups" {
  for_each = var.module_enabled ? local.groups : tomap({})

  package_id = cloudflare_waf_package.package[0].id
  zone_id    = var.zone_id
  group_id   = each.value.group_id
  mode       = each.value.mode
}

locals {
  rules = { for b in var.rules : b.rule_id => b }
}

resource "cloudflare_waf_rule" "rules" {
  for_each = var.module_enabled ? local.rules : tomap({})

  package_id = cloudflare_waf_package.package[0].id
  zone_id    = var.zone_id
  rule_id    = each.value.rule_id
  mode       = each.value.mode
}
