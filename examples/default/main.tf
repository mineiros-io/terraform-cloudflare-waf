locals {
  zone_id = "ae36f999674d196762efcc5abb06b345"
}

resource "cloudflare_zone_settings_override" "settings" {
  zone_id = local.zone_id
  settings {
    waf = "on"
  }
}

module "cloudflare" {
  source = "../"

  zone_id    = local.zone_id
  package_id = "1e334934fd7ae32ad705667f8c1057aa"

  groups = [
    {
      # Cloudflare Drupal
      group_id = "8df6c9aaddcbdf0eceb047bc50873697"
      mode     = "off"
    },
    # ...
  ]
}

module "user" {
  source = "../"

  zone_id    = local.zone_id
  package_id = "1e334934fd7ae32ad705667f8c1057aa"

  groups = []
  rules  = []
}

module "owasp_modsecurity_core_rule_set" {
  source = "../"

  zone_id     = local.zone_id
  package_id  = "c504870194831cd12c3fc0284f294abb"
  sensitivity = "off"
  action_mode = "challenge"

  groups = [
    {
      # OWASP Bad Robots
      group_id = "07d700cf30fda7548be94ff01087d0c4"
      mode     = "on"
    },
    # ...
  ]
}
