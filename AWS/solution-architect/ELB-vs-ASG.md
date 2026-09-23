# Elactic Load Balancing (ELB)

* ELB are servers that forwards traffic to mutiple ec2 servers(instamces).
* It spread load across multiple downstream servers(Instances)
* Because load balancers does health checks, failure of downstream servers can be handled easily.
* Health check are done regularly to all the instances.
* It exposes  asingle point of access to to the application.
* HIghly availability accross zones.
* Provides SSL termiation (HTTPS) for websites.
  
## WHY USE ELB

1. ELB is a managed load balancer
2. AWS manages ELB
3. It cost less to setup.
4. Its is integratesd with many AWS  services (EC2, EEC2 Auto sclaing group, EC, Cloudwatch, Route 53, etc.)

## Health check

1. THis is a way the ELB verify whether or not an EC2 instance is working properly.
2. Health check is done on av port and route.
3. If the health check os not 200 (ok), the the instance is unhealthy.

## Types of load balancers on AWS

1. Classic Load Balancer (v1 - old genration) - 2009: AWS doees not wnat peoeple to use this load banalcer anymore. (It supports HTTP, HTTPS, TCP, SSL, Secure TCP)
This load abalncer has been deprecated.

2. Application Load Balancer (v2 new generation) - (HTTP & HTTPS)
   * Works on Layer 7 Application layer.
   * It inspect the content of the traffic (like URLs and headers) and make more intelligent routing decisions based on that content. 
   * Allows to route to muliple HTTP applications accross machine (target groups)
   * Fixed hostname (xxx.region.elb.amaaxonlaws.com)
   * Application servers will not see the ip of the client direlty
  
3. Network Load Balancer (v2 new generation) - 
   * Works on Layer 4 load balancer (tcp, udp)
   * It looks at the basic network information like IP addresses and port numbers to make routing decisions.
   * They don't inspect the content of the data being sent (like what the customer is ordering). 
   * They simply forward the network packets to the appropriate server.
   * Very fast and efficient, designed for handling high volumes of traffic with minimal latency.
   * Has one static IP address per AZ. (Spport Elastic IP )
   * Its not included in the AWS free tier
   * HeLTH CHECK SUPPORT (TCP, HTTP, HTTPS)
   * All traffic goes trough the NLB in the security group

   ## Network LB Target groups

   1. EC2 instance
   2. Ip addresses (Must be Private)
   3. Application load balancer
  
4. Gateway Load Balancer (2020) - It operates atNetwork layer (lAYER 3)

* Use a Gateway load balancer when you want all traffic to pass through firewall, intrusion, detection, inpection e.t.c before it reaches thje application
* pass the traffics from the User - route table - Target grop - Gateway Load Balancer - Application
* It operates at the network layer
* It uses GENEVE Protocol on port 6081
* Target groups (It can be EC2 Instance or IP ADDRESS(private))

## Sticky Session

* A sticky session is known as session persistence, is a technique used in load balancing to ensure that all requests from a single user during a session are directed to the same Specific backend server.

* When sticky sessions are enabled, the load balancer "sticks" a user to a specific server for the duration of their session.
This means that once a user's request is directed to a particular server, all subsequent requests from that user will be routed to the same server.

* The cookie used for sticky sessions has an expiration date.
The load balancer inserts a cookie into the user's browser.
This cookie contains information that identifies the server the user is connected to

** Disadvanatages 
1. Uneven distribution of traffic across the servers if some users have longer sessions than others.
1. Potential for data loss: If a server with active sticky sessions fails, the users connected to that server may lose their session data.

## COOKIE NAMES 
1. Application based cookie 
2. Duration based cookie 


## CROSS-ZONE BALANCING

1. With croass Zone Load Blanceer : Each load balancer instance ditribute traffic evenly accross all registed instances in AZ

2. Without cross Zone load balancer: Requests are distributeed ib the einstnce eof the node eof the elactic load balancer.

Application load balancer:

* Cross-zone blanacing is emabled by default at the Taget group level.
* No charges for the innter AZ data

Network & GatewayLoad Balancer

* Disbled by default
* You have to pay to enable ithe cross zone balancer

Classic Load Blancer

* Disbaled by defult
* You will not be charge if you  enable the cross zone load balancer.

## NOTE : The following cookie names are reserved by the ELB (AWSALB, AWSALBAPP, AWSALBTG)

## SSL/TLS (SSL: Secure Socket Layer)
TLS: Transport layer secuirty (Newer version of SSL)
* SSL/TLS is like a security guard for your websites. 
* SSL basically encrypt ythe communication betweena webserver and a web browser. 
* The encrytion protects sensistve data like passwords, credit card info, and personal details. 
* SSL Certificate allows traffic between CLIENT and load balancer to be encrpted in transit
* SSL certificate has an expiration dates (You must renew to make sure that the certificate is valid)
* The load balancer uses X.509 certificates
* Public SSL Certificates are issed by Certificate Authorities. (GoDaddy, e.t.c)
* You can manage certificate in AWS using 'AWS CERTIFIED MANAGER'
* You can also upload your own certificates alternativly.

## SERVER NAME IDICTATION
* For Exmaple, if multiple website are hosted on the same servers, they would have to share the same IP address.
* That means the servers would not know the website you are tryig to access.
* However, with SNI (Server Name Indication),the browser tells the exact website you are trying to reach right at the beginning of the connection by specifiying the hostname of the target server. 
* The server loads multiple SSL certificate to serve multiple website.
* It presents the correct SSL certificate for that specific website you are trying to reach. 
* It only works when you use ALB /NLB

## Connection Draining 
When using:
   - CLB == It is called connection drianing 
   - ALB & NLB == Deregistration Delay 

* This is a feature with servwrs that have load balancers.
* It ensure that ongoing request to a server are not interrupted when the server needs to be removed from services ( maybe like for updates, maintenancem, failute etc.).
* How it works:
=> When a server nees to be remove the load balancer is notified. 
=> Instead of immediately stopping the trafic, the load balancer allows existing request to the server to complate.
=> Any new requeset to the server will be stopped. 
* Between 1- 3600 seconds (300 seconds is the default)

# AUTO SCALING GROUP (ASG)
For Example, I have a website and s lot of poepla re visiting the website at once because of the sale i have going on the website, my website might slow down or even crash. So
* ASG watches the website traffic and automatically adds more servers when the traffic is hight or remove servers with the traffic is slow.
* It scales in {Remove EC2 INSTANCE} and scales out (ADD EC2 Instance). 
* It makes sure we have a minimum and maximum number of eC2 instances RUNNING.
* Automatically register new isnatnces to a load balancer
* Re-create an EC2 INSTANCE in case the previos EC2 instance is terminated.
* ASG makes website to be more relaible and cost effective by adjusting the number of server based on the demand. 
* ASG is free in AWS
How it works: 
=> Set uo Min and Max Capacity 
=> Also set up desired capacity. 


## Attributes of ASG

1. Launch template
2. Min size / Max size capacity
3. Scaling policies

## Auto scaling with Cloud watch & SCALING

1. You can scale in & out in ASG using the cloud watch alarm.
2. Alarm monitors the custom metrics or Average CPU

## Auto scaling Groups -Scaling Policiees
git 
1. Dynamiic Scaling Pilicies

* Target Tracking Scaling
  * Most simple and easy to set up
  * Used to track the average CPU utilization  of any autoscaling group to stay like aroud 40%
* Simple /Stp Scaling
  * A cloudwatch alarm is triggered (Example: When CPU goes over 70% , add 2 instances) or {CPU is below 30& , then remove 1 instance}
* Scheduled Actions
      * Anticipate a scaling based on the known uage pasttern

2. Predictive sclaing
   Continually having to forecast adn schedule scaling ahead
   * Good metrics to scale on
         1. CPU Utilization
         2. Reques Count Per Target  
         
