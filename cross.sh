#!/bin/bash

# Replace these values with your own
new_user_name="cross-user"

# Create the IAM user
aws iam create-user --user-name $new_user_name

# Generate access keys for the user
keys=$(aws iam create-access-key --user-name $new_user_name)

# Extract the access key and secret key from the response
access_key=$(echo "$keys" | jq -r '.AccessKey.AccessKeyId')
secret_key=$(echo "$keys" | jq -r '.AccessKey.SecretAccessKey')

# Display the access key and secret key
echo "IAM User: $new_user_name"
echo "Access Key: $access_key"
echo "Secret Key: $secret_key"

