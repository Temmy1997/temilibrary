# Implementing a Static Website Hosting on S3 Bucket with Terraform

## QUESTION:

1. Use terraform to create a s3 bucket startic website and a cloud front distribution in front of it. 
2. Make sure you can access the static website using the cloud front url Make sure the bucket is private

Cloudfront 
* Content delivery network
* Ensures website content is located as close as possible to the end user

## Solution:

## Step 1- Update the AWS Profile

aws configure --profile (profile-name)

## Step 2-  Create index.html and error.html 

* Place these files in the same directory as the main.tf file.

## Step 3: Create the Provider Configuration
1. Terraform interact with cloud providers, SaaS providers, and other APIs.
2. It created using the provider block 
3. For this project, user AWS provider to interact with the many resources supported by AWS. 
4. You must configure the provider with the proper credentials before you can use it.
''' 
terraform {         
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "temi"
}

'''
# Explaining the code above:
## Terraform Configuration Block:
1. terraform { ... }: This block defines the Terraform configuration itself.
2. required_providers: This section defines the external providers required for this infrastructure.
3. required_version = "5.0": This line specifies the minimum Terraform version required to run this configuration. 

## AWS Provider Block:

1. provider "aws": This block configures the AWS provider we defined earlier.
2. profile = "temi": This tells Terraform to use the temi AWS profile configured in your local AWS credentials.
Note:
Make sure you have a proper AWS profile set up with the necessary permissions to create S3 buckets and configure web hosting.
3. region = "us-east-1": This line specifies the AWS region where your infrastructure will be deployed.

## STEP 4 2. variables.tf

This file defines variables for your configuration.
'''
variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "temi-tf-bucket"
  type        = string
}
'''

## STEP 4 Create the Configuration for S3 bucket

Create a ‘bucket.tf’ file to store the terraform configuration related to the S3 bucket.

## STEP 5 Create outputs.tf 
This file outputs the CloudFront distribution domain name after the resources are created.

## STEP 6
Run the folloeing commands 

1. terraform init 
Initializes the Terraform working directory, downloading necessary provider plugins.

2. terraform plan 

3. terraform apply 
Applies the configuration to create the defined resources. It will prompt for confirmation before proceeding.
Confirm the apply: Type yes to confirm the apply.

