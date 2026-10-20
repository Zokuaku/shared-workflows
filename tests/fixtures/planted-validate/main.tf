terraform {
  required_version = ">= 1.6.0"
}

# PLANTED DEFECT: this output refers to a variable that is never declared, so
# `terraform validate` must fail.
output "greeting" {
  description = "Refers to an undeclared variable."
  value       = var.undeclared
}
