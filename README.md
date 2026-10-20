# shared-workflows

Reusable GitHub Actions workflows for my Terraform module repositories. Every module repository
runs the same checks, defined once here and pinned by version, so a change to the pipeline is
one reviewed release instead of the same edit in every repository.

## Use it

In a module repository, `.github/workflows/checks.yml`:

```yaml
name: checks
on:
  pull_request:
  push:
    branches: [main]
permissions:
  contents: read
jobs:
  checks:
    uses: Zokuaku/shared-workflows/.github/workflows/terraform-module.yml@v0.2.0
```

And `.github/workflows/release.yml`, so every version tag becomes a GitHub Release whose notes
are that version's section of `CHANGELOG.md`:

```yaml
name: release
on:
  push:
    tags: ["v*.*.*"]
permissions:
  contents: write
jobs:
  release:
    uses: Zokuaku/shared-workflows/.github/workflows/release.yml@v0.2.0
    with:
      tag: ${{ github.ref_name }}
```

A tag with no `## vX.Y.Z` section in the changelog is refused, so every release says what
changed. This repository releases itself the same way ([`on-tag.yml`](.github/workflows/on-tag.yml)).

## What it checks

| Check | Command | Fails when |
|---|---|---|
| `fmt` | `terraform fmt -check -recursive` | a file is not in canonical format |
| `validate` | `terraform validate`, in the module and in every `examples/*` | the configuration is invalid |
| `tflint` | `tflint` with the module's own `.tflint.hcl` | a lint rule is broken (the repository chooses its rules) |
| `test` | `terraform test` | a test in `tests/*.tftest.hcl` fails |
| `scan` | [checkov](https://www.checkov.io/), Terraform checks, from its container image pinned by digest | a security or configuration-hygiene check fails. A finding the module accepts on purpose is skipped in its own `.checkov.yaml`, with the reason, where the choice is reviewed |

Each check is its own job, so each is its own status check and can be made required on its own.
Tests are meant to run against mocked providers, so the checks need no cloud account and no
credentials.

## Inputs

| Input | Default | Meaning |
|---|---|---|
| `working_directory` | `.` | the module root |
| `terraform_version` | `1.16.6` | exact Terraform version |
| `tflint_version` | `v0.64.0` | exact TFLint version |
| `checkov_image` | `bridgecrew/checkov:3.3.29@sha256:3cc1…` | the scanner image, pinned by digest |
| `checks` | `fmt validate tflint test scan` | which checks to run |
| `expect_failure` | `false` | for the self-test below only |

## How it tests itself

A check that cannot catch a mistake is not a check. [`self-test.yml`](.github/workflows/self-test.yml)
runs the workflow against [`tests/fixtures/`](tests/fixtures/): a clean module that must pass every
check, and five modules that each carry one planted defect (bad formatting, an undeclared
variable, an unused variable, a failing test, an unprotected storage bucket). Each of those must
make its own check fail. The release workflow runs as a dry run against a fixture changelog: it
must build the notes for a version that has a section, and refuse one that does not.

## Versions and pinning

- Releases are tagged `vMAJOR.MINOR.PATCH` with a [changelog](CHANGELOG.md). Callers pin a tag;
  a breaking change is a new major version.
- Every third-party action is pinned to a full commit id, with its release in a comment. A tag
  can be moved; a commit cannot.
- Terraform and TFLint versions are exact, never ranges.

## Licence

[Apache-2.0](LICENSE).
