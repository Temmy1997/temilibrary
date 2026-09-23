Simulate a web application system outage in production 

•⁠  ⁠code deploy 
•⁠  ⁠⁠autoscaling group 
•⁠  ⁠⁠ec2 instances 
•⁠  ⁠⁠application load balancer 
•⁠  ⁠⁠cloudwatch

# AWS CODEDEPLOY 
- It is a deployment service that automates application deployments. to various AWS compute services like Amazon EC2, AWS Fargate, AWS Lambda, and even on-premises servers.
0 It contains information about what to deploy and how to deploy it. 

## Deployment Types (for EC2/On-Premises)
1. In-place: 
- The application on each instance in the deployment group is stopped while the latest revision is installe
- The new version is started. 
- This can result in downtime if not managed carefully with deployment configurations.

2. Blue/Green: 
- A new set of instances (the "green" environment) is provisioned with the latest application revision. 
- Traffic is then shifted from the old instances (the "blue" environment) to the new ones. 
- This minimizes downtime and allows for easier rollback. \
- Auto scaling group is needed when using blue/green deployment 


Project 
1. Create Service role 
For EC2/On-Premises deployments, attach the AWSCodeDeployRole policy.

* Choose an IAM service role that grants CodeDeploy permissions to manage your EC2 instances or on-premises instances. **  

2. Go to CodeDeploy, create an Application. 

3. Click and Create Deployment group 

* (Deployment group defines which instance code deploy will deploy the application to and how the deployment should be carried out)
 Name: 


 Rules with source of 0.0.0.0/0 allow all IP addresses to access your instance. We recommend setting security group rules to allow access from known IP addresses only.


 sudo yum install -y httpd
sudo yum install -y wget
sudo yum install -y rubyls
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo systemctl status codedeploy-agent

Deploy a Static Website to S3
    •    Goal: Automate deployment of a static website to an S3 bucket.
    •    Tools: Jenkins, GitHub, AWS CLI, S3
    •    Steps:
    •    Store static files (HTML/CSS/JS) in a Git repo.
    •    Create a Jenkins job to pull the repo and sync files to an S3 bucket.
    •    Set S3 bucket for static website hosting.






