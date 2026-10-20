variable "name" {
  description = "Who to greet. Lower-case letters, digits and hyphens only."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "The name must be lower-case letters, digits and hyphens."
  }
}
