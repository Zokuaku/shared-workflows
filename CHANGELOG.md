# Changelog

All notable changes. Versions follow [semantic versioning](https://semver.org/).

## v0.1.0 - 2026-10-20

First release.

- `terraform-module.yml`: reusable checks for a Terraform module - `fmt`, `validate` (module and
  every example), `tflint`, `test`. Terraform 1.16.6 and TFLint v0.64.0 by default. Actions pinned
  by commit: `actions/checkout` v7.0.1, `hashicorp/setup-terraform` v4.0.1,
  `terraform-linters/setup-tflint` v6.3.2.
- `self-test.yml`: a clean fixture module must pass every check; one planted defect per check
  must make that check fail.
