terraform {
  required_version = ">= 1.6.0"
}

# PLANTED DEFECT: declared and never used. Valid Terraform, correctly formatted - only the
# linter's terraform_unused_declarations rule can catch it.
variable "unused" {
  description = "Declared and never used."
  type        = string
  default     = "unused"
}
