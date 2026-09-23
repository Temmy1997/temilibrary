# IAM

* An IAM (Identity and Access Management) policy in AWS is a JSON document that defines permissions. It specifies what actions are allowed or denied on AWS resources. Here's a breakdown of the structure:

1. Version:
Specifies the version of the policy language. The latest version is usually recommended.
Example: "Version": "2012-10-17"

2. Statement:
Contains one or more individual statements that define permissions.
Each statement has the following elements:

* Effect:
Specifies whether the statement results in an allow or deny.

* Values: "Allow" or "Deny"

* Action:
Lists the specific actions that are being allowed or denied.
Uses service-specific prefixes followed by the action name (e.g., "s3:GetObject", "ec2:RunInstances").
Can use wildcards (*) to specify multiple actions (e.g., "s3:List*").

* Resource:
Specifies the AWS resources that the policy applies to.
Uses Amazon Resource Names (ARNs) to identify resources uniquely.
Can use wildcards to specify multiple resources.
Example: "arn:aws:s3:::my-bucket", "arn:aws:ec2:*:*:instance/*"
Condition (Optional):

Adds conditions that must be met for the statement to apply.
Uses condition operators and keys to define conditions.
