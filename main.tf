locals {
  anomaly_packages = [for p in data.cloudflare_waf_packages.anomaly.packages : p.id]
}

data "cloudflare_waf_packages" "anomaly" {
  zone_id = var.zone_id

  filter {
    detection_mode = "anomaly"
  }
}

resource "cloudflare_waf_package" "package" {
  count = var.module_enabled && contains(local.anomaly_packages, var.package_id) ? 1 : 0

  depends_on = [var.module_depends_on]

  zone_id     = var.zone_id
  package_id  = var.package_id
  sensitivity = var.sensitivity
  action_mode = var.action_mode
}

locals {
  groups = { for g in var.groups : g.group_id => g }
}

resource "cloudflare_waf_group" "groups" {
  for_each = var.module_enabled ? local.groups : tomap({})

  package_id = var.package_id
  zone_id    = var.zone_id
  group_id   = each.value.group_id
  mode       = each.value.mode
}

locals {
  rules = { for r in var.rules : r.rule_id => r }
}

resource "cloudflare_waf_rule" "rules" {
  for_each = var.module_enabled ? local.rules : tomap({})

  package_id = var.package_id
  zone_id    = var.zone_id
  rule_id    = each.value.rule_id
  mode       = each.value.mode
}
