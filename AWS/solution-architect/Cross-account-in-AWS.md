1. Create bash script that create an iam user and create secret key and access key

EXAMPLE
#!/bin/bash

## Replace these values with your own
new_user_name="cross-user"

## Create the IAM user
aws iam create-user --user-name $new_user_name --profile temi.user

## Generate access keys for the user
keys=$(aws iam create-access-key --user-name $new_user_name --profile temi.user)
 
## Extract the access key and secret key from the response
access_key=$(echo "$keys" | jq -r '.AccessKey.AccessKeyId')
secret_key=$(echo "$keys" | jq -r '.AccessKey.SecretAccessKey')

## Display the access key and secret key
echo "IAM User: $new_user_name"
echo "Access Key: $access_key"
echo "Secret Key: $secret_key"

2. Create a users in the target account in the AWS Console 
3. Create the access key and secret key (This is give an AWS CLI access to the target account)
4. Create a trust-policy json file. (Replace the arn to the arn of the source account)
This allows source account to assume the role in the traget account 

EXAMPLE:
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Principal": {
            "AWS": "arn:aws:iam::983827065304:user/cross-user"
        },
        "Action": "sts:AssumeRole"
    }]
}
5. With the trust policy create the role in the target account. 

EXAMPLE: 

aws iam create-role --role-name CrossAccountRole --assume-role-policy-document file://trust_policy.json --profile newtemi

6. Define what the iam role is capable of doing when it is assumed by attaching a policy/permission 

EXAMPLE:
## (Policy that grant read-only access to Amazon EC2 resources)

aws iam attach-role-policy --name CrossAccountRole --policy-arn arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess --profile newtemi 

7. In the source account, Assume the role in the target account. (Using the ARN of the IAM Role

* create a policy that allows its principal to assume the role in Prod. 
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": "arn:aws:iam::933033698773:role/CrossAccountRole"
    }
}

Note: Use the ARN of the target IAM role 

* Create a policy to create an IAM managed policy that you will associate with an IAM user.

aws iam create-policy --policy-name TargetAccountAccess --policy-document file://./assume_role_target.json --profile temi.user 

8. ATTach  the policy to the source iam user (cross-user)

aws iam attach-user-policy --user-name cross-user --policy-arn arn:aws:iam::983827065304:policy/TargetAccountAccess --profile temi.user

9. Create a profile that will use the role in your target account

* Create a new CLI profile called target and will append the given role_arn to ~/.aws/config.
## COMMAND
aws configure set profile.target.role_arn arn:aws:iam::933033698773:role/CrossAccountRole

* Sets the source_profile, which references the default credentials profile so that you can use the same IAM user for Dev and Prod.

aws configure set profile.target.source_profile default

10.  Check the ~/.aws/config file