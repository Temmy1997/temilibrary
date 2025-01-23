# EC2 
* EC2 = Elastci computer cloud = Infracstructure as a service.
* It consiste of several resources :
1. EBS = Storing date on virtual drives 
2. ELB = Distribing load accross machines 
3. ASG = Scaling services using an auto scaling group. 

## EC2 Configuration 
* Operating system = Linux, Windows or Mac OS
* Storage: 
    1. Network attached = EBS , EFS
    2. Hardware = EC2 Instance store 
* Firewall = Security group 
NOTE: THERE ARE MORE FUNCTIONS 

## EC2 INSTANCE TYPES 
AWS has the following naming convention. For Example (m5.2xlarge)

m = instance class
5 = generation of the instance 
2xlarge = Size within the instance class (The more the size the more the moemeory)


# EC2 PURCHASING OPTIONS

1. On-Demand Insatnce
* Good for short workload 
* Has predicatbale prices 
* Pay by second

2. EC2 Reserved Instances
* You can reserve EC2 instances with its attributes for 1 or 3 years.
* Good for long workloads. 

3. Savings plan
* Good for long workloads
* Commited to an amount of usage, but usage beyond the EC2 savings plan is billed on ON-DEMAND PRICE.


4. Spot Instance 
* Good for short workload 
* Cheapest EC2 purchasing option
* Less reliable (You can lose your EC2 instance)

5. Dedicated Hosts 
* Book an entire physical server with EC2 instances 
* It is the most expensive option, bacause you reserve a physical server 

6. Dedicated Instance 
* No other customers will share your hardware. 
* These are the instance that run on the hardware (Dedicated host) dedicated to you. 

1. Used for companies with strong compliance needs
2. Used for software that have complicated licensing models. 

7. EC2 Capacity reservation 
* Resreve on-demand instnces capacity in a specific AZZ in any duration


## Compute Optimized 
Compute Optimized EC2 instances are great for compute-intensive workloads requiring high-performance processors (e.g., batch processing, media transcoding, high-performance computing, scientific modeling & machine learning, and dedicated gaming servers).

## Storage Optimized 
* EC2 instances are great for workloads requiring high, sequential read/write access to large data sets on local storage.
* Handle this high-frequency OLTP database

## Memory Optimized
EC2 instances are great for workloads requiring large data sets in memory.

## Spot Fleet 
1. Spot Fleet is a set of Spot Instances and optionally On-demand Instances.
2. It allows you to automatically request Spot Instances with the lowest price.

## Elastic Network Interfaces (ENIs) 
* Bounded to a specific AZ. 
* You can not attach an ENI to an EC2 instance in a different AZ.

## EC2 Hibernate
* To enable EC2 Hibernate, the EC2 Instance Root Volume type must be an EBS volume
* Must be encrypted to ensure the protection of sensitive content.

# EC2 Placement Group 

## Cluster Placement Groups 
* Place your EC2 instances next to each other which gives you high-performance computing and networking.

## Spread Placement Group 
* places your EC2 instances on different physical hardware across different AZs.

## Security Group 
* Used to control traffic in and out of EC2 instances
* Security Groups can be attached to multiple EC2 instances within the same AWS Region/VPC.
* Its like a firewall on the EC2 instance. 

Security group includes 
1. Access to ports 
2. Ip ranges (ipv4 and ipv6)
3. Inbound network (From internet to the instance)
4. Outbound network (From instance to the internet)

Notes about Security Groups (SG):
1. Can be attached to multiple instances (1 Instance have mutiple SG)
2. Seperate one SG for SSH access. 
3. Application not accessible is caused by an issue from the SG. 
4. By default all inbound traffic is BLOCKED and all outbound traffic is authourize.

## PORTS TO KNOW 
* 22 - SSH (Secure Shell) (Log into a linux instance)
* 21 - FTP (File trasnfer - uPLOAD FILES INTO A FILESHARE)
* 22 SFTP (File trasnfer - Upload files using SSH)
* 80 - HTTP (Access to unsecure website)
* 443 HTTPS (Access to secure website)
* 3389 - RDP (Remote Desktop Protocol) Log into window instance. 

# EC2 PLACEMENT GROUP 
==> To have control how the EC2 instance are placed. 

## CATEGORIES OF PLACEMENT GROUPS 
==> CLUSTERS: Instances grouped together within a SINGLE AZ. 
Provides great network connectivity between instances. 
    ** IF AZ fails all the instances will fail at the same time**

==> SPREAD: Instances spread across diffrent hardware (Used when you have critical application)
Can be used across diff AZ.
Designed for applications that need to run on a small number of instances but want to avoid single points of failure.

==> PARTITION: Instances are spread across partitions IN MILTIPL AZ, where each partition is isolated from others
Useful for large distributed and fault-tolerant applications.
Allows for scaling across multiple Availability Zones (but the partitions themselves are still within the same region).

# ELASTIC NETWORK INTERFACE (ENI)
==> ENU represent a virtual network card.
==> Gives EC2 access to the network .

## Atributes of ENI 
==> One primary private ipv4, and one or more secondary ipv4.
