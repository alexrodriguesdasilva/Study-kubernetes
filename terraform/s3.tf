resource "aws_s3_bucket" "bucket-backend-tfstate" {
    bucket = "labs-cka-study-alerodrigues"
    force_destroy = true
    versioning {
        enabled = true
    }
    lifecycle {
        prevent_destroy = false
    }
    tags = var.tags
} 