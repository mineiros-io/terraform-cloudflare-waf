# terraform-cloudflare-waf
<!-- BEGIN TERRAFORM DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.7, < 2.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_waf_group.groups](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_group) | resource |
| [cloudflare_waf_package.package](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_package) | resource |
| [cloudflare_waf_rule.rules](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_rule) | resource |
| [cloudflare_waf_packages.anomaly](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/waf_packages) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_mode"></a> [action\_mode](#input\_action\_mode) | (Optional) The action mode of the package, can be one of ['block', 'challenge', 'simulate']. | `string` | `null` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A list of WAF groups. | `any` | `[]` | no |
| <a name="input_module_depends_on"></a> [module\_depends\_on](#input\_module\_depends\_on) | (Optional) A list of external resources the module depends\_on. Default is '[]'. | `any` | `[]` | no |
| <a name="input_module_enabled"></a> [module\_enabled](#input\_module\_enabled) | (Optional) Whether to create resources within the module or not. Default is 'true'. | `bool` | `true` | no |
| <a name="input_package_id"></a> [package\_id](#input\_package\_id) | (Required) The WAF Package ID. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) A list of WAF rules. | `any` | `[]` | no |
| <a name="input_sensitivity"></a> [sensitivity](#input\_sensitivity) | (Optional) The sensitivity of the package, can be one of ['high', 'medium', 'low', 'off']. | `string` | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | (Required) The DNS zone ID to apply to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_groups"></a> [groups](#output\_groups) | All 'cloudflare\_waf\_group' resource attributes. |
| <a name="output_module_enabled"></a> [module\_enabled](#output\_module\_enabled) | Whether the module is enabled. |
| <a name="output_package"></a> [package](#output\_package) | All 'cloudflare\_waf\_package' resource attributes. |
| <a name="output_rules"></a> [rules](#output\_rules) | All 'cloudflare\_waf\_rule' resource attributes. |

<!-- END TERRAFORM DOCS -->