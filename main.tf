# S3 static website bucket

# Resource-1: aws_s3_bucket
resource "aws_s3_bucket" "mywebsite" {
  bucket        = "${var.bucket_name}-${random_id.suffix.hex}"
  tags          = var.tags
  force_destroy = true
}

# Resource-2: aws_s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "mywebsite" {
  bucket = aws_s3_bucket.mywebsite.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Resource-3: aws_s3_bucket_versioning
resource "aws_s3_bucket_versioning" "mywebsite" {
  bucket = aws_s3_bucket.mywebsite.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Resource-4: aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "mywebsite" {
  bucket = aws_s3_bucket.mywebsite.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Resource-5: aws_s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "mywebsite" {
  bucket = aws_s3_bucket.mywebsite.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
EOF





