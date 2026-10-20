# A module with no provider at all, so the self-test downloads nothing and needs no cloud
# account. It exists to exercise the checks, not to build anything.
locals {
  greeting = "hello, ${var.name}"
}
