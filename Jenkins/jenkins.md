# JENKINS
 * jenkins is an open-source automation platform that helps to automate parts of the software development process. 
 * It is used for building deploying and automating software development task. to automate the building, testing, and deployment of software applications. Jenkins provides hundreds of plugins to support building, deploying, and automating any project.
 * It is a popular tool for continuous integration and continuous deployment (CI/CD) pipelines.
 * Just project a web GUI 

## KEY CONCEPTS 
1. Job: This is a task or process  that you want to automate ( E.G Building code, runnign )


## Jenkins Infractructire
1. Master server:
        a. Controls pipeline 
        b. Schedules Builds 

2. Agent Server
        a. Run the builds in their work space. 
    
    TYPES OF AGAENT 
    1. Permananet Agent
        - Must have dedicated servers for running jobs
    2. Cloud Agent
        - DOCKER , Kuberneties, AWS Cloud

## BUILD TYPES 
1. Freestlye Build 
        - Very simple methos to createv a build 
        - Most freestlye build is usee to execute a scheel script 
2. Pipelines 
        - Use Jenkin files writin in a groovy syntax tp specify waht happens in the build 
        - It broken into 5 diffrent stages {CLONE, BUILD, TEST, PACKAGE , AND DEPLOY}

* JSON (JavaScript Object Notation) is a lightweight, text-based, and language-independent data interchange format that is easy for humans to read and write and for machines to parse and generate. It is primarily used for transmitting data between a server and a web application, as an alternative to XML.

In JSON, data is represented in key-value pairs and organized into a nested tree structure, making it easy to represent complex data structures such as arrays and objects. Here is an example of a JSON object:
 

# JENKINS INSTALLATION STEPS 

## Install jenkins server on vagrant vm 
https://www.technology-tips.com/jenkins-installation-linux-7/

## Install Jenkins on AWS Amazon 2023 
https://gist.github.com/darinpope/6fa74d29e0e604ea648ac7d6ab2e5195

## Note: The Jenkins jey is 
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

## Install Jenkins on AWS Amazon linux 2 
https://blog.g33kzone.com/jenkins-installation


## Linux home directory
/var/lib/jenkins


Webhooks allow external services to be notified when certain events happen. When the specified events happen, we’ll send a POST request to each of the URLs you provide. Learn more in our Webhooks Guide.

# JENKINS PROJECT
Deploy a simple apache website to a server using Jenkins + ansible + git
Hint: Use git to hold your ansible playbook, then create a jenkkins job to pull the playbook from git and run the ansible playbook on the target server (edited) 
Note: Servers should be in EC2 
1. Create 2 EC2 instance. 
## Note
        a. Make sure the EC2 instance has enough storage
        b. Both instance should have the same public key and privake key. 
        c. Attach IAM role that gives the instance full admin permission 
        d. AMI is Amazon linux 2 

2. Remote into the the control server 
 Do the following:
        a. yum epel-releaase 
        b. yum update 
        c. Install JenkinS, {Use this Blog} & Access your Jenkins console 
## Install Jenkins on AWS Amazon linux 2 
https://blog.g33kzone.com/jenkins-installation
        d. In the Jenkins console, install the ssh and ansible plugins
        e. Create a virtual env with python3 
                python3 -m venv jenkins_env
                source jenkins_env/bin/activate
                pip3 install boto3 
                pip3 install botocore
                ansible-playbook -i ansible/aws_ec2.yml ansible/deploy_apache.yml
        e. create a directory (ansible)
        f. cd into the directory , create the ansible play book and the 

python3 -m venv jenkins_env
source jenkins_env/bin/activate
pip3 install boto3 
pip3 install botocore
ansible-playbook -i ansible/aws_ec2.yml ansible/deploy_apache.yml

## Pipeline Format
Pipeline supports two syntaxes:
1. SCRIPTED 
* Build pipeline using a Groovy-based DSL (Domain Specific Language)
* It allows you to express your build process as code

## Basic structure and elements of a scripted Jenkinsfile:
1. Start by defining the pipeline using the pipeline block. 
2. Specify where you want the pipeline to run using the agent block. 
3. Divide your build process into stages using the stage block.
4. Within each stage, define the actual steps using the steps block. 
5. Specify post-build actions using the post block.
--- Define steps to be executed after the entire pipeline or specific stages.

Start with {node}
* Uses a DSL (domain spseciifc lanagauge) based on Groovy which a scripting language or the java virtual machine


2. DECLARATIVE 
* Start with {pipeline} 
* Specially designed for configuring jenkins project as code 
* Has 3 required secrions 
        1. agent 
                * Speciifes where the pipeline will be run
                * Parameters are :
                        * any = Run the pipeline using the first available operating system {}
                        * label = Run pipeline on a spsecific operating system or on a server where a specific tool is installed 
                        * docker = Run pipelines inside a container using a specified image 
                        * none = Allows to use diffrent agents for each stage in the pipeline. 


        2. stages 
                * Identify specific parts of the process being automated 
                * Each stage must contain one step a section.

# RUN SCRIPTS FROM PIPELINE 
Pipeline cn be used to call scripts that are stored in a repo with a Jenkinsfile.

## Pipeline steps for Calling scripts 
1. sh() = Run shell comands on Linux, Unix, Marc 
2. bat () = Run shell comands on Windows.

## Status BADGE 


## SECURING JENKINS 
1. Matrix based authourization = Limit permission for users in jenkins 
2. Project based permission = Limit the access to specific jobs and folders 
