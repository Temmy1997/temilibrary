variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "my temi_tf_bucket"
  type        = string
  default     = "temi-tf-bucket-2024"
}

