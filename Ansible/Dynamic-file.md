# Dynamic Host Inventory File

* In a cloud setup (e.g AWS] the inventory file constantly changes as you add or decommission servers.
* A dynamic inventory is a script written in Python, PHP or any other programming language.
* * It comes in handy in cloud environments such as AWS where IP addresses change once a virtual server is stopped and started again.
* A script that is used to create a dynamic inventory has to be made executable so that Ansible can use it.

## Setup Ansible AWS Dynamic Inventory

1. Install Python
   sudo yum install python3 -y
2. Create a python3 virtual environment
python3 -m venv myenv
source myenv/bin/activate
deactivate (Deactiviate the env) 
3. Install the boto3 library.

* Ansible uses the boot core to make API calls to AWS to retrieve ec2 instance details.

  pip3 install boto3

4. Innnstall aws cli on server 

5. Create an inventory directory under /opt and cd into the directory.
   sudo mkdir -p /opt/ansible/inventory
   cd /opt/ansible/inventory\
6. Create a file named aws_ec2.yaml in the inventory directory.
   sudo vi aws_ec2.yaml
7. Since my ansible is running inside the AWS environment, attach an ec2 instance role with the required AWS ec2 permissions.

Note:
This way you don’t have to add the access and secret key in the configuration. Ansible will automatically use the attached role to make the AWS API calls.

6. Open /etc/ansible/ansible.cfg file.
   sudo vi /etc/ansible/ansible.cfg

* Find the [inventory] section and add the following line to enable the ec2 plugin.
  [enable_plugins = aws_ec2]

REFRENCES:

https://medium.com/geekculture/a-complete-overview-of-ansible-dynamic-inventory-a9ded104df4c

#  ANSIBLE PROJECTS 
 Use Ansible to automate the provisioning of virtual machines or cloud instances. You can write playbooks to create, configure, and manage virtual machines on platforms such as AWS, Azure, or VirtualBox.


# Soltion for Ansible Contol in AWS 
1. Create the EC2 instances 
2. Prerequisites 
## Install Ansible 
sudo yum install ansible -y 
## Install Python
   sudo yum install python3 -y
## Create a python3 virtual environment
python3 -m venv temi-env
## Activate the virtual environment
source temi-env/bin/activate
## Install the boto3 library.
pip3 install boto3

NOTE: 
Ansible uses the boot core to make API calls to AWS to retrieve ec2 instance details.
3. Attach IAM Role to the EC2 instance 
## The IAM roles must have EC2 fullacess policy attached to it 

4. Open /etc/ansible/ansible.cfg file.
   sudo vi /etc/ansible/ansible.cfg
## Find the [inventory] section (/inventory in vim) and add the following line to enable the ec2 plugin.
  [enable_plugins = aws_ec2]

# SOLUTION FOR ANSIBLE CONNTOL USING ACCESS KEY AND SECRET KEYS
         USING ANSILE ROLES 

1. Create a user and add give the useer admin acess 
2. ## Install Python
   brew install python3 
## Create a python3 virtual environment
python3 -m venv temi-env
## Activate the virtual environment
source temi-env/bin/activate
## Install the boto3 library.
pip3 install boto3
pip3 install botocore
## Install ansible 
yum install ansible
## Install awscli 
 pip3 install boto awscli 

3. aws configure  
## Generate key pair that will help to connect to the remote host 
## Log into your AWS account to get your “AWS_ACCESS_KEY_ID” and “AWS_SECRET_ACCESS_KEY”. 
## Go to “IAM”. 
## Create a new user or select an exiting one. 
## Go to “Security Credentials” and click “Create Access Key”.

NOTE: Ansible’s EC2 module uses python-boto library to call AWS API, and boto needs AWS credentials in order to function.

4. Create key pair 
* ssh-keygen
* The .awsconfig and credentials file will be created automatically and located in the {.aws} folder 
* The plubic key is saved in {/Users/temitope/.ssh/id_rsa.pub} 
* Private Key = {/Users/temitope/.ssh/id_rsa}
* Upload the key pair to aws ec2 
## Note: Go to this AWS DOCUMENTATION {https://docs.aws.amazon.com/cli/latest/reference/ec2/import-key-pair.html} TO FIND THIS: 
    aws ec2 import-key-pair --key-name "ansible" --region us-east-1 --public-key-material fileb://~/.ssh/id_rsa.pub 
--- You will see y=the ansible keys in EC2 Key pair 

5. Create a folder for the role
## mkrir roles 
## cd roles 
## ansible-galaxy role init create-ec2-instance
## vim roles/create-ec2-instance/tasks/main.yml 
- name: Create EC2 instance
  amazon.aws.ec2_instance:
    name: "ansible-instance"
    instance_type: "{{ instance_type }}"
    image_id: "{{ image_id }}"
    region: "{{ region }}"
    key_name: "{{ key_name }}"
    security_group: "launch-wizard-3"
    vpc_subnet_id: subnet-0b72dcfd4f2dbb3bf
    network:
      assign_public_ip: true
    profile: temi
    count: 1
    tags:
      ansible: worker

- name: Print EC2 instance IP
  debug:
    var: amazon.aws.ec2_instance.public_ip
## Create a folder for the variables(OPTIONAL)  or put the vars in the playbook. 

6. Create the playbook 
## vim ec2.yml 
## name: Create EC2 instance
  hosts: localhost
  vars:
    instance_type: "t2.micro"
    image_id: "ami-06e46074ae430fba6"
    key_name: "ansible"
    region: "us-east-1"
  roles:
  - roles/create-ec2-instance

7. Final step 
## Run the playbook 
ansible-playbook -i inventory/aws_ec2.yaml ec2.yml

REFRENCE 
1. https://foxutech.com/how-to-create-ec2-instance-using-ansible-role/
2. https://foxutech.com/how-to-create-ec2-instance-using-ansible/
   



Create Role 
ansible-galaxy role init create-ec2-instance


  become: yes - MEANS TO RUN USER AS ROOT 
  