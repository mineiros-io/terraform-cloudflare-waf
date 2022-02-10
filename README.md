[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-cloudflare-waf)

[![Build Status](https://github.com/mineiros-io/terraform-cloudflare-waf/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-cloudflare-waf/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-cloudflare-waf.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-cloudflare-waf/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-cloudflare-waf

A [Terraform] module for creating and managing a 
[Cloudfare Web Application Firewall](https://www.cloudflare.com/en-gb/waf/)
resource.

**_This module supports Terraform version 0.14.7 up to (not including) version 2.0
and is compatible with the Terraform Cloudfare Provider version 3**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Main Resource Configuration](#main-resource-configuration)
  - [Module Configuration](#module-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Cloudfare Documentation](#cloudfare-documentation)
  - [Terraform AWS Provider Documentation](#terraform-aws-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following Terraform resources

- `cloudflare_waf_packages`
- `cloudflare_waf_package`
- `cloudflare_waf_group`
- `cloudflare_waf_rule`

## Getting Started

Most common usage of the module:

```hcl
module "terraform-cloudflare-waf" {
  source = "git@github.com:mineiros-io/terraform-cloudflare-waf.git?ref=v0.0.1"

  zone_id    = "zone-id"
  package_id = "package-id"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Main Resource Configuration

- [**`zone_id`**](#var-zone_id): *(**Required** `string`)*<a name="var-zone_id"></a>

  The DNS zone ID to apply to.

- [**`package_id`**](#var-package_id): *(**Required** `string`)*<a name="var-package_id"></a>

  The WAF Package ID.

- [**`sensitivity`**](#var-sensitivity): *(Optional `string`)*<a name="var-sensitivity"></a>

  The sensitivity of the package, can be one of ['high', 'medium',
  'low', 'off'].

- [**`action_mode`**](#var-action_mode): *(Optional `string`)*<a name="var-action_mode"></a>

  The action mode of the package, can be one of ['block', 'challenge',
  'simulate'].

- [**`groups`**](#var-groups): *(Optional `list(group)`)*<a name="var-groups"></a>

  A list of WAF groups.

  Default is `[]`.

  Each `group` object in the list accepts the following attributes:

  - [**`group_id`**](#attr-groups-group_id): *(**Required** `string`)*<a name="attr-groups-group_id"></a>

    The WAF Rule Group ID.

  - [**`mode`**](#attr-groups-mode): *(**Required** `string`)*<a name="attr-groups-mode"></a>

    The mode of the group, can be one of ["on", "off"].

- [**`rules`**](#var-rules): *(Optional `list(rule)`)*<a name="var-rules"></a>

  A list of WAF rules.

  Default is `[]`.

  Each `rule` object in the list accepts the following attributes:

  - [**`rule_id`**](#attr-rules-rule_id): *(**Required** `string`)*<a name="attr-rules-rule_id"></a>

    The WAF Rule ID.

  - [**`mode`**](#attr-rules-mode): *(**Required** `string`)*<a name="attr-rules-mode"></a>

    The mode of the rule, can be one of ["block", "challenge",
    "default", "disable", "simulate"] or ["on", "off"] depending on the
    WAF Rule type.

### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies.
  Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

  Example:

  ```hcl
  module_depends_on = [
    null_resource.name
  ]
  ```

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`package`**](#output-package): *(`object(package)`)*<a name="output-package"></a>

  All `cloudflare_waf_package` resource attributes.

- [**`groups`**](#output-groups): *(`map(groups)`)*<a name="output-groups"></a>

  All `cloudflare_waf_group` resource attributes.

- [**`rules`**](#output-rules): *(`map(rules)`)*<a name="output-rules"></a>

  All `cloudflare_waf_rule` resource attributes.

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

## External Documentation

### Cloudfare Documentation

- https://www.cloudflare.com/en-gb/waf/

### Terraform AWS Provider Documentation

- https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_group
- https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_package
- https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_rule
- https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/waf_packages

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-cloudflare-waf
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[releases-aws-provider]: https://github.com/terraform-providers/terraform-provider-aws/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[aws]: https://aws.amazon.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-cloudflare-waf/issues
[license]: https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-cloudflare-waf/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/CONTRIBUTING.md
