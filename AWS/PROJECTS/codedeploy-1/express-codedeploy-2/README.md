# NodeJs TypeScript Express App Deploy to EC2 using AWS S3 Artifact.

Steps
1. Clone this very repo. 
2. Set up AWS Stuff
    2.1. Create key pair - and copy that to the home directory
    2.2. Security Groups - Add 3000 and 22 ports. 
    2.3. Create a bucket - typescript-express-artifact 
    2.4. Create a role with S3 full access. 
    2.5. Create a demo IAM User and configure the AWS Cli. 
    2.6 AWS Cli - install : https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
3. Create the instance - and choose key pair and security group
4. SSH into the instance and install nodejs 
5. Create project folder in the server. 
6. AWS Cli
7. Upload files from the local repo to the S3 bucket. 
8. Copy from the S3 bucket to the project directory, Run npm install, npm run build and node dist/index.js
9. Show the output 

Rinse and repeat till you find peace. 

# In the project terminal to upload the project zip to aws s3.
zip -r project.zip . -x node_modules\* dist\* .git\* && aws s3 cp project.zip s3://code-deploy-temi/code-deploy-2/project.zip




# In the server
aws s3 cp s3://typescript-express-artifact-2/code-deploy-2/project.zip project.zip
unzip -o project.zip -d Code/express-codedeploy-2/
npm install --prefix Code/express-codedeploy-2/
npm run build --prefix Code/express-codedeploy-2/
sudo systemctl restart node-api.service


aws s3 cp s3://typescript-express-artifact-2/code-deploy-2/project.zip project.zip && unzip -o project.zip -d Code/express-codedeploy-2/ && npm install --prefix Code/express-codedeploy-2/ && npm run build --prefix Code/express-codedeploy-2/ && sudo systemctl restart node-api.service