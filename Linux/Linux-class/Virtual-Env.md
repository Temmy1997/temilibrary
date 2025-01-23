# Create a Python 3 virtual environment

Make sure that python3, pip2, boto3, and botocore is installed

## Create a Python 3 virtual environment, follow these steps:

1. python3 -m venv temi-env
   NOTE: This will create a new virtual environment in the env directory.
2. 2. Activate the virtual environment
   Code:  source temi-env/bin/activate
3. Your virtual environment is now active
4. You can use pip3 to install packages as needed.
   CODE:
   pip3 install boto3 botocore
5. When you are finished working in the virtual environment, you can deactivate it by running the following command:

   {deactivate}
python3 -m venv jenkins_env
source jenkins_env/bin/activate
pip3 install boto3 
pip3 install botocore
ansible-playbook -i ansible/aws_ec2.yml ansible/deploy_apache.yml

 -u ec2-user


 