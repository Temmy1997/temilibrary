# AMAZON EKS (ELASTIC KUBERNETES SEEVICE)
- It laanches managed kubernetes cluster on AWS.
- NOo need to install, operate, and maintain your own Kubernetes control plane or nodes.
- Kubernetes is an open-source tool for automatic deployment, scaling, and management of containerized docker applications.
- It jsut like ECS but with diff API 
- kubenetes if open source but ECS is not open-source
- It supports 2 launch mode 
        - EC2 launch type (Needs EC2 INSTANCES)
        - Fargate Launch mode (Severless)
- EKS is cloud-agnostic (Can be used with any cloud provider when migrating)

## EKS NODE TYPES
1. MANAGED NODE GROUPS 
- AWS helps you provision and manage the worker nodes.
- You define the instance types and scaling configurations, and EKS takes care of launching, updating, and terminating the nodes.   
- The nodes are going to be part of an ASG managed by EKS 
- Support ON-DEMAND and SPOT INSTANCES 


2. SELF-MANAGED NODES
- Nodes will be created by you and registered to the EKS cluster and managed by an ASG.
- You provision and manage the EC2 instances yourself and then connect them to your EKS control plane. This gives you more control over the underlying infrastructure.
- You can use the prebuilt AMAZON EKS OPTIMISED AMI (optional)
- Support ON-DEMAND and SPOT INSTANCES 

3. AWS FARGATE 
- No nodes required 
- NO mantainance 

## EKS WITH DATA VOLUME 
- You can attach data volume to EKS cluster 
- You need to specify {STORAGECLASS MANISFEST} on the EKS CLUSTER 
- It leverages a {container Storage Interface} compliant driver 
- 

