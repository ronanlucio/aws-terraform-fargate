provider "aws" {
  region = "${var.aws_region}"
}

# Create S3 bucket to store terraform state
resource "aws_s3_bucket" "backend_terraform" {
  bucket        = "${var.app_name}-backend-terraform"
  force_destroy = true
}

# Set bucket ACL to private
resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.backend_terraform.id
  acl    = "private"
}

# Enable versioning
resource "aws_s3_bucket_versioning" "backend_terraform" {
  bucket = aws_s3_bucket.backend_terraform.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Create DynamoDB table for terraform lock state
resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "${var.app_name}-terraform-locks"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}