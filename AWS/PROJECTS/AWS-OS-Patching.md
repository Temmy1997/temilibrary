# EC2 Instance Patching in MultiAccount and Multi-Region
##  Here is the Process:

1. In the management account, the EventBridge is triggered based in the cron rule.

2. The EventBridge rule will then invoke /execute a lambda function, which will initiate the multi account and multiregion automation workflow.

3. The system manager role assumes the execution role in each target account and region.

4. The execution role initiates a run command task for (AWSRunPatchBaseline). The run command task will scan and install missing updates on the target instances based on the memebership provided in the AWS Resource Group 

## 

1. Create Resource Group 
    The Resources group will be created for diffrent env:
        Production
        Teset 
        Non-prod 
# Resources group in AWS allows you to organize and manage AWS resources based on shared tags and other criteria. 
# Resource group must be crested in ever target account 


2. All the Target account need to have an IAM roles names {AWS-SYSTEMSMANAGER-AUTOMATIONEXECUTIONROLE}

3. An automated document has been created in the managed account (Devops Account)

