# Terraform configuration for creating an s3_bucket to store the Terraform state files

terraform {
  required_version = "~> 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.7"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket        = local.bucket_name
  acl           = local.acl
  force_destroy = var.force_destroy

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
