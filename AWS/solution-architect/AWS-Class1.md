EC2 SERVICE 

- This is a service for creating and configuring automations for the creaion of Virtual machines 

- It also contains other amazing tools 
  - auto-scaling group 
  - Elastic Load balancers 
  - Networking ( security group ) 
  - Permissions ( IAM ROLE ) 
  - and lots more you can see from the management console 
  

-> everything you can do from the mgt console, can be done and even more from the command line

-> VPC: Virtual private cloud 
  - This is an isolated environment created in an aws account 
  - we can multiple vpc per region in an aws account so far the ip addresses do not overlap 

-> Subnet: This is a fraction of a VPC created to host resources that has same networking requirements 
  - Public subnet: This means a fraction of our vpc meant to host resources that should be able to communicate forth and back with the public internet(0.0.0.0/0)
     - resources like webserver that serves users on the internet 
	 - Loadbalancer(
	 
  - Private subnet:  This means a fraction of our vpc meant to host resources that cannot communicate with the internet  
     - RDS (Database resources ) 
	 - any other resource that cannot be accessed from the internet

Security Group 

-> This is an instance-level firewall 

Internet Gateway 

-> This is just like the default gateway on your local wifi connection 
-> This helps to route traffic to the internet 
-> It is found in the VPC service 

Route Table 

-> This is where you specify the route to different destinations 
-> You associate subnets 	 

PROJECTS 
#ASSIGNMENT 

-> we create temi VPC 

-> we will create 2 subnets from the Temi-VPC 
   - Public subnet 
   - Private subnet 

-> we will create 2 ec2 instances 
   - Public-instance 
   - Private-instance 
   
     
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

   
  ARCHITECTURE 
  
  
  USERS ON THE INTERNET 
  
  
  
  
  
  
  
  
  
  
  
  