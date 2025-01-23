# Creating EC2 instance with CLI

## Create Key Pair 
aws ec2 create-key-pair --key-name NewKeyPair --query 'KeyMaterial' --output text > NewKeyPair.pem

* To check for key pairs 
 aws ec2 describe-key-pairs

* To see the security group that we have
aws ec2 decribe-security-groups 



* delete key pair 
aws ec2 delete-key-pair --key-name MyKeyPair






