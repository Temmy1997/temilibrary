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


# # Explaining the code above:

# # Terraform Configuration Block:
# # terraform { ... }: This block defines the Terraform configuration itself.
# 2. required_providers: This section defines the external providers required for this infrastructure.
# 3. required_version = "5.0": This line specifies the minimum Terraform version required to run this configuration. 

# # AWS Provider Block:

# 1. provider "aws": This block configures the AWS provider we defined earlier.
# 2. profile = "temi": This tells Terraform to use the temi AWS profile configured in your local AWS credentials.
# Note:
# Make sure you have a proper AWS profile set up with the necessary permissions to create S3 buckets and configure web hosting.
# 3. region = "us-east-1": This line specifies the AWS region where your infrastructure will be deployed.