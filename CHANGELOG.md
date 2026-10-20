# Changelog

All notable changes. Versions follow [semantic versioning](https://semver.org/).

## v0.2.0 - 2026-10-20

- `terraform-module.yml`: a fifth check, `scan` - checkov 3.3.29 (Terraform checks) from its
  container image pinned by digest; a module skips a finding on purpose in its own
  `.checkov.yaml`. It runs by default.
- `release.yml`: a reusable release - each version tag becomes a GitHub Release whose notes are
  that version's CHANGELOG section; a tag without one is refused. `on-tag.yml` releases this
  repository with it.
- `self-test.yml`: a planted unprotected bucket must fail the scan; the release notes are built
  for a fixture version and refused for a missing one (dry runs - nothing is released).

## v0.1.0 - 2026-10-20

First release.

- `terraform-module.yml`: reusable checks for a Terraform module - `fmt`, `validate` (module and
  every example), `tflint`, `test`. Terraform 1.16.6 and TFLint v0.64.0 by default. Actions pinned
  by commit: `actions/checkout` v7.0.1, `hashicorp/setup-terraform` v4.0.1,
  `terraform-linters/setup-tflint` v6.3.2.
- `self-test.yml`: a clean fixture module must pass every check; one planted defect per check
  must make that check fail.
