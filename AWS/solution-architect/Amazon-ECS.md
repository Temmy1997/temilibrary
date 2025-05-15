# AMAZON ECS (AMAZON ELACTIC CONTAINER SERVICES)
- ECS is a fully managed container orchestration service. 
- Amazon ECS helps you easily run, manage, and scale applications that are packaged in containers on AWS without you having to manage the servers themselves.

- When you Launch Docker conatiner on AWS = you launch and ECS task on ECS clusters. 
- 
## ECS WITH EC2 LAUNCH TYPE
- EC2 instances are  virtual servers in AWS. 
-  But you have to manage the underlying computers (EC2 instances). 
- When you use ECS with EC2, you create an ECS cluster.  
- This cluster is like a group of these EC2 virtual machinesnthat you've told ECS it can use to run your containers. 
- For ECS to manage the containers on your EC2 instances, you need to run a special piece of software called the {ECS agent} on each of your EC2 instances within the cluster. 
- ECS agent talks to the main ECS service and tells it what's happening on that EC2 instance (like how much resources are being used) and does what ECS tells it to do (like start or stop a container).
- 

## ECS WITH FARGATE LAUNCH TYPE
- Fargate is another way ECS can run those containers.
- But you don't have to manage the underlying computers (EC2 instances) at all!. 
- It serverless.
- It doesn't mean there are no servers. It just means you don't have to worry about them. AWS completely manages the servers for you.
- AWS runs the ECS tasks based on the CPU/RAM needed. 
- To scale - just increase the number of task.
- it is easier to manage 

# IAM ROLES FOR ECS 
- IAM Roles provide a secure way to grant permissions to your containers to access other AWS services without needing to manage long-term credentials.

### EC2 INSTANCE PROFILE 
- Only for EC2 launch type 
- Used by ECS agent only 
- ECS agent makles API calls to ECS Service.
- Send container to Cloudwatch logs.
- Pull docker image from ECR. 
- Refrence sensitive data in {SECRET MANAGER} or {SSM PARAMETER STORE}

### ECS TASK ROLES 
- Both used for EC2 LAUCH TYPE & FARGATE.
- You can create specific role per each ECS TASKS.
- Each role allows to be limit easch role to each ECS services.


# ECS LOAD BALANCER INTEGRATION
- ECS can work with different types of AWS Load Balancers.

- You link the Load Balancer to your ECS Service
- When you create or update your ECS service, you tell it which load balancer to use and how it should direct traffic to your containers. 

1. Application Load Balancer (ALB):
- It can route traffic to different containers based on the requested path or hostname. 
- This is great for microservices where different parts of your application run in separate containers.   

2. Network Load Balancer (NLB): 
- This operates at a lower level (network level) and is designed for high performance and low latency.

- It's good for applications that use protocols other than HTTP/HTTPS or need very fast connections. 
   
# ECS WITH DATA VOLUMES (EFS)
- ECS need to store and access data that persists even when the container itself stops or restarts.
- EFS is like a network-based shared hard drive in the AWS cloud. 
- Data on EFS survives even if the underlying ECS instances fail, are replaced, or are scaled down.
- In your ECS task, you need to define a "volume" and specify that it's an EFS volume.

# ECS WITH AUTOSCALING 
- Automatically increase the number of ECS tasks
- We can scale on
    - ECS CPU utilization
    - ECS scale on RAM
    - ALB request cont per target

When using ECS Laucnh type with Autoscaling, there are 2 options 
1. AUTOCALING GROUP SCALING 
- We can scale the ASG based on CPU utilization 
- We can add EC2 instances over time by yourself 

2. EC2 CLUSTER CAPACITY PROVIDER
- Automatically scales the infractructure for the ECS tasks.
- Add ec2 instance when you are missing capacity in {CPU , RAM} 
- This one is better

