terraform {         
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region  # Use the variable for the region
  profile = "temi"
}

## Create the S3 bucket
resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket_name

  # Tags for the S3 bucket
  tags = {
    Name        = "Static Website Hosting"
    Environment = "Dev"
  }
}

# Configure the S3 bucket for website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_website.id 
  
  index_document {
    suffix = lookup(var.website_config, "index_document", "index.html")
  }

  error_document {
    key = lookup(var.website_config, "error_document", "error.html")
  }
}