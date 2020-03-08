provider "aws" {
  region = "us-east-2"
}

#Create S3 bucket to store state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-udemy-jo-20200308"

  #Enable versioning so we can see full revision history of state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# DynamoDB for state locks
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-udemy-jo-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Terraform backend configuration for remote state
terraform {
  backend "s3" {
    bucket       = "tf-udemy-jo-20200308"
    key          = "gobal/s3/terraform.tfstate"
    region       = "us-east-2"

    dynamodb_table = "tf-udemy-jo-state-locks"
    encrypt      = true
  }
}

# Creating outputs of state bucket and dynamodb for didactic purposes
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket where we store state"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "the name of the DynamoDB table for state locks"
}
