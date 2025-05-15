# ELASTIC BEANSTALK 
* Elastic Beanstalk is a service designed to make deploying and managing web applications on AWS easier. 
* Think of it as a helpful assistant that takes care of the underlying infrastructure, allowing you to focus on your code. What 

## What Elastic Beanstalk Does:

* Simplifies Deployment:
- You provide your application code (e.g., in a ZIP or WAR file).
- Elastic Beanstalk handles the rest:
        - Provisioning the necessary AWS resources (EC2 instances, load balancers, etc.).
        - Configuring the operating system and web server.
        - Deploying your application.

* Manages Infrastructure:
    - It monitors the health of your application and automatically scales resources based on demand.
    - It provides tools for monitoring logs and performance.

* Supports Multiple Languages:
Elastic Beanstalk supports popular programming languages and frameworks, including:
    - Java
    - .NET
    - PHP
    - Node.js
    - Python
    - Ruby
    - Go
    - Docker

## Beanstalk is free, but you will pay for the underlying instances. 

## Elastic Beanstalk Concepts:

1. Application:
Your web application code.

2. Environment:
    - The runtime environment for your application, including the EC2 instances, load balancers, and other resources.
    - Tiers: web server environment tier & worker environment tier. 
    - You can create mutiple environment in beanstalk. 

3. Application Version:
    - A specific version of your application code.

4. Platform:
    - The operating system and runtime environment for your application (e.g., "64bit Amazon Linux 2 running Python 3.8").

## PROCESS
1. Create an application 

2. Upload Version: Upload an application version in the form of an application source bundle (for example, a Java .war file) to Elastic Beanstalk.

3. Launch the environment: Elastic Beanstalk automatically launches an environment and creates and configures the AWS resources needed to run your code.

4. Manage envirionment: you can then manage your environment and deploy new application versions. 
