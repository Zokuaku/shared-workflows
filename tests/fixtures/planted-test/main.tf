terraform {
  required_version = ">= 1.6.0"
}

output "answer" {
  description = "A fixed value the test below checks."
  value       = 41
}
