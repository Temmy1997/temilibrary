variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "website_config" {
  description = "Configuration for the static website hosting"
  type        = map(string)
  default = {
    index_document = "index.html"
    error_document = "error.html"
  }
}