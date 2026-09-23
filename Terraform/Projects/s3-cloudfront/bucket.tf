resource "aws_s3_bucket" "temi-tf-bucket-2024" {
  bucket = var.bucket_name

  tags = {
    Name        = "My-terraform-bucket"
    Environment = "Dev"
  }
}

# aws_s3_bucket "temi-tf-bucket-2024": Creates an S3 bucket with the specified name.
# bucket: Uses the bucket_name variable for the bucket name.
# tags: Adds tags to the bucket for identification.

resource "aws_s3_bucket_website_configuration" "temi-tf-bucket-2024_website" {
  bucket = aws_s3_bucket.temi-tf-bucket-2024.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# aws_s3_bucket_website_configuration "temi-tf-bucket-2024_website": Configures the S3 bucket for static website hosting.
# bucket: Refers to the bucket created earlier.
# index_document: Specifies index.html as the index document.
# error_document: Specifies error.html as the error document.

# resource "aws_s3_bucket_acl" "temi-tf-bucket-2024_acl" {
#     bucket = aws_s3_bucket.temi-tf-bucket-2024.id
#     acl    = "private"
# }

# aws_s3_bucket_acl "temi-tf-bucket-2024_acl": Sets the ACL (Access Control List) for the S3 bucket to private.
# bucket: Refers to the bucket created earlier.
# acl: Sets the bucket's ACL to private.

resource "aws_s3_bucket_policy" "temi-tf-bucket-2024_policy" {
  bucket = aws_s3_bucket.temi-tf-bucket-2024.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AllowCloudFrontServicePrincipalReadOnly",
        Effect: "Allow",
        Principal: {
          "AWS": "aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn"
          }
        Action: "s3:GetObject",
        Resource: "${aws_s3_bucket.temi-tf-bucket-2024.arn}/*"
      }
    ]
  })
}

# aws_s3_bucket_policy "temi-tf-bucket-2024_policy": Attaches a policy to the S3 bucket to restrict access.
# bucket: Refers to the bucket created earlier.
# policy: Defines the bucket policy in JSON format. It allows only CloudFront to access the objects in the bucket based on the Referer header condition.
# policy = jsonencode({...}) -- This defines the actual policy in JSON format, it converts the provided HCL structure into a JSON string that represents the bucket policy.
# Version: The version of the policy language (set to "2012-10-17" which is the latest version as of now).
# Statement: A list of statements (only one in this case) that define the permissions.
# Sid: (Statement ID) An optional identifier for the policy statement, in this case, "PublicReadGetObject".
# Effect: The effect of the policy statement. Here, it's "Allow", meaning it grants the permission specified.
# Principal: Specifies who is allowed or denied access. Here, * means the policy applies to everyone (all users).
# Action: The specific action that is allowed or denied. Here, "s3
# " allows the action of retrieving objects from the S3 bucket.
# Resource: Specifies the resources to which the policy applies. ${aws_s3_bucket.temi-tf-bucket-2024.arn}/* dynamically includes the ARN (Amazon Resource Name) of the S3 bucket created earlier, with a wildcard (*) to apply to all objects in the bucket.
# Condition: Specifies conditions that must be met for the policy to apply. Here, it uses the StringEquals condition to check the Referer header.
# StringEquals: Checks if the value of the AWS:Referer key is equal to the specified value(s).
# "AWS:Referer": ["${aws_cloudfront_distribution.website_distribution.domain_name}"]: The policy condition ensures that the Referer header matches the CloudFront distribution domain name. This restricts access to objects in the bucket to only requests that come through the specified CloudFront distribution.

## Uploading a file to a bucket
resource "aws_s3_object" "index" {
  bucket = var.bucket_name
  key    = "index.html"
  source = "index.html"
  acl    = "private"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = var.bucket_name
  key    = "error.html"
  source = "error.html"
  acl    = "private"
  content_type = "text/html"
}

# aws_s3_object "index" and aws_s3_object "error": Uploads the index.html and error.html files to the S3 bucket. Both files are set to private.
# For static websites, it is generally a good practice to specify the content type to ensure the browser interprets the files correctly.


#####################################
#    CLOUDFRONT DISTRIBUTION        #
#####################################

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "OAI for S3 bucket"
}
# aws_cloudfront_origin_access_identity "origin_access_identity": Creates an Origin Access Identity (OAI) to allow CloudFront to access the S3 bucket privately.


resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name = aws_s3_bucket.temi-tf-bucket-2024.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.temi-tf-bucket-2024.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for my terraform website"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.temi-tf-bucket-2024.id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name        = "My Website Distribution"
    Environment = "Dev"
  }
}

# aws_cloudfront_distribution "website_distribution": Configures the CloudFront distribution to serve content from the S3 bucket.
# origin: Sets the S3 bucket as the origin for CloudFront, using the OAI to grant access.
# enabled: Enables the CloudFront distribution.
# is_ipv6_enabled: Enables IPv6 for the distribution.
# comment: Adds a comment for identification.
# default_root_object: Sets the default root object to index.html.
# default_cache_behavior: Configures caching behavior, including allowed methods, target origin, and caching settings.
# forwarded_values: Specifies which values (query strings, cookies) are forwarded to the origin.
# viewer_protocol_policy: Ensures that HTTP requests are redirected to HTTPS.
# restrictions: No geo-restrictions are applied.
# viewer_certificate: Uses the default CloudFront certificate.
# tags: Adds tags for identification and management.
