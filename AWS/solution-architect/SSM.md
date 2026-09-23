# AWS SYSTEM MANAGER
System manager is a AWS services that manages resources inside AWS account (Like ec2 instance eith windows or linux)
* If the resource is an EC2 instance, we have to attach the SSM policy to a role and attach therole to the EC2 instance. 
* Latest EC2 AMI have SSM agent reconfigured or else we will have to install it on the server. 
* SSM is used to connect to EC2 instance withouth using private or public key 
* If the resource is anIAM roles is used to delegate access to manage ec2 instances 

## Amazon Machine Images (AMIs) with SSM Agent preinstalled
Amazon Linux Base AMIs dated 2017.09 and later
Amazon Linux 2
Amazon Linux 2 ECS-Optimized Base AMIs
Amazon Linux 2023 (AL2023)
Amazon EKS-Optimized Amazon Linux AMIs
macOS 10.14.x (Mojave), 10.15.x (Catalina), 11.x (Big Sur), and 12.x (Monterey)
SUSE Linux Enterprise Server (SLES) 12 and 15
Ubuntu Server 16.04, 18.04, 20.04, and 22.04
Windows Server 2008-2012 R2 AMIs published in November 2016 or later
Windows Server 2016, 2019, and 2022

## Check if SSM is installd 
sudo systemctl status amazon-ssm-agent

## RUN COMMAND 
* Provide a way to execute task without ssh or rdp into the ec2 instance servers
* The tasks are = installing, configuring e.t.c 

## STATE MANAGER 
* Used to control how and when configurations are applied on machine (e.g EC2 iNSTANCE)
* It allows you to define and maintain consistent configurations for your Amazon EC2 instances and other AWS resources
* State Manager uses documents written in JSON or YAML format to describe the desired state of your instances and the tasks that should be performed.

## key concepts and features of AWS Systems Manager State Manager
1. Documents:
Define the actions to be performed on your instances.
Written in JSON or YAML format.

2. Associations:
Way you link a document with one or more instances. 
They define when and where the document should be executed.

3. Targets:
Instances or resources on which the document should be executed. 
You can target individual instances, groups of instances, or even resources like S3 buckets.
4. Execution History:
Maintains an execution history that provides details about when a document was executed, on which instances, and the status of the execution.

5. Predefined Documents:
AWS provides a set of predefined documents for common tasks, such as installing or updating software, configuring security settings, and more.

6. Custom Documents:
You can create custom documents tailored to your specific needs. 
These documents can include scripts, commands, or any other necessary configuration.
7. Schedule Expressions:
Supports scheduling document executions using cron-like expressions, allowing you to automate tasks at specific times or interval

# INVENTORY 

# PACTH MANAGER 

# PARAMETER 


# RUNNING ANASIBLE PLAYBOOK USING AWS SYSTEMS MANAGER
1. Create an IAM role with SSM  policy
2. Attach the IAM role to the two EC2 instances
   Note: Latest AMI for EC2 instance has an alreday installed SSM agent
   If the instance does not have, install the SSM agent on the EC2 instance
   To cheeck if you have the service run (systemctkl status amazon-ssm-agaent)
3. Check fleet manager under node management section in SSM for the EC2 iNSTANCES
4. Got to Statemanager in AWS system, manager 
5. Create an association
6. In other to run ansible playbook from Github or S3, you would have to choose AWS-RunRemoteScript Document. 
Note: AWS-RunRemoteScript Document: 
Execute scripts stored in a remote location. The following remote locations are currently supported: GitHub (public and private) and Amazon S3 (S3). The following script types are currently supported: #! support on Linux and file associations on Windows
