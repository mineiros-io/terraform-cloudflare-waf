header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-cloudflare-waf"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-cloudflare-waf/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-cloudflare-waf/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-cloudflare-waf.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-cloudflare-waf/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/terraform-0.14.7+%20|%202-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-cloudflare-waf"
  toc     = true
  content = <<-END
    A [Terraform] module for creating and managing a 
    [Cloudfare Web Application Firewall](https://www.cloudflare.com/en-gb/waf/)
    resource.

    **_This module supports Terraform version 0.14.7 up to (not including) version 2.0
    and is compatible with the Terraform Cloudfare Provider version 3**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module implements the following Terraform resources

      - `cloudflare_waf_packages`
      - `cloudflare_waf_package`
      - `cloudflare_waf_group`
      - `cloudflare_waf_rule`
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most common usage of the module:

      ```hcl
      module "terraform-cloudflare-waf" {
        source = "git@github.com:mineiros-io/terraform-cloudflare-waf.git?ref=v0.1.1"

        zone_id    = "zone-id"
        package_id = "package-id"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Main Resource Configuration"

      variable "zone_id" {
        required    = true
        type        = string
        description = <<-END
          The DNS zone ID to apply to.
        END
      }

      variable "package_id" {
        required    = true
        type        = string
        description = <<-END
          The WAF Package ID.
        END
      }

      variable "sensitivity" {
        type        = string
        description = <<-END
          The sensitivity of the package, can be one of ['high', 'medium',
          'low', 'off'].
        END
      }

      variable "action_mode" {
        type        = string
        description = <<-END
          The action mode of the package, can be one of ['block', 'challenge',
          'simulate'].
        END
      }

      variable "groups" {
        type        = list(group)
        default     = []
        description = <<-END
          A list of WAF groups.
        END

        attribute "group_id" {
          required    = true
          type        = string
          description = <<-END
            The WAF Rule Group ID.
          END
        }

        attribute "mode" {
          required    = true
          type        = string
          description = <<-END
            The mode of the group, can be one of ["on", "off"].
          END
        }
      }

      variable "rules" {
        type        = list(rule)
        default     = []
        description = <<-END
          A list of WAF rules.
        END

        attribute "rule_id" {
          required    = true
          type        = string
          description = <<-END
            The WAF Rule ID.
          END
        }

        attribute "mode" {
          required    = true
          type        = string
          description = <<-END
            The mode of the rule, can be one of ["block", "challenge",
            "default", "disable", "simulate"] or ["on", "off"] depending on the
            WAF Rule type.
          END
        }
      }
    }

    section {
      title = "Module Configuration"

      variable "module_enabled" {
        type        = bool
        default     = true
        description = <<-END
          Specifies whether resources in the module will be created.
        END
      }

      variable "module_depends_on" {
        type           = list(dependency)
        description    = <<-END
          A list of dependencies.
          Any object can be _assigned_ to this list to define a hidden external dependency.
        END
        default        = []
        readme_example = <<-END
          module_depends_on = [
            null_resource.name
          ]
        END
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported in the outputs of the module:
    END

    output "package" {
      type        = object(package)
      description = <<-END
        All `cloudflare_waf_package` resource attributes.
      END
    }

    output "groups" {
      type        = map(groups)
      description = <<-END
        All `cloudflare_waf_group` resource attributes.
      END
    }

    output "rules" {
      type        = map(rules)
      description = <<-END
        All `cloudflare_waf_rule` resource attributes.
      END
    }

    output "module_enabled" {
      type        = bool
      description = <<-END
        Whether this module is enabled.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "Cloudfare Documentation"
      content = <<-END
        - https://www.cloudflare.com/en-gb/waf/
      END
    }

    section {
      title   = "Terraform AWS Provider Documentation"
      content = <<-END
        - https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_group
        - https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_package
        - https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/waf_rule
        - https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/waf_packages
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-cloudflare-waf"
  }
  ref "hello@mineiros.io" {
    value = " mailto:hello@mineiros.io"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "releases-aws-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-aws/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "aws" {
    value = "https://aws.amazon.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-waf/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-waf/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-waf/blob/main/CONTRIBUTING.md"
  }
}
