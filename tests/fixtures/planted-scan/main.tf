terraform {
  required_version = ">= 1.6.0"
}

# PLANTED DEFECT: a storage bucket with no public-access block, no versioning, no logging and
# no encryption settings. Valid and well-formatted Terraform - only the security scan catches it.
resource "aws_s3_bucket" "planted" {
  bucket = "planted-defect-example"
}
