#!/bin/bash

# Replace these values with your own
BUCKET_NAME="temi1997-bucket"
INDEX_HTML="/c/Users/fidel/temitope/repos/temi-library/AWS/aws-certs/solutions-architect/code/s3/index.html"
COFFEE_JPG="/c/Users/fidel/temitope/repos/temi-library/AWS/aws-certs/solutions-architect/code/s3/coffee.jpg"
ERROR_DOCUMENT="error.html"

# Create S3 bucket
aws s3 mb s3://$BUCKET_NAME --region us-east-1 --profile temi.user

# Upload files

aws s3 cp $INDEX_HTML s3://$BUCKET_NAME  --profile temi.user --region us-east-1

aws s3 cp $COFFEE_JPG s3://$BUCKET_NAME  --profile temi.user --region us-east-1


# Configure bucket as a static website
aws s3 website s3://$BUCKET_NAME/ --index-document index.html --error-document error.html --profile temi.user --region us-east-1

# Disable all public access settings
aws s3api put-public-access-block --bucket $BUCKET_NAME --profile temi.user --region us-east-1--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

# Set public access policy for the bucket
aws s3api put-bucket-policy --bucket $BUCKET_NAME --profile temi.user --region us-east-1 --policy '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::'$BUCKET_NAME'/*"
    }
  ]
}'
