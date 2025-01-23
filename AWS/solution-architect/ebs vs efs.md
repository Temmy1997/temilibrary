# Elastic network Interface 
It represent a virtual netwotk card 
Bound to a specific AZ (Availabilty zone) 

# ELACTIC  BLOCK VOLUME (EBS) 
* This is netwpork bdrive that can attached to an instance. 
* User can still get data even after an instance is terminated. 
* EBS Volume cannot be atta hed to two EC2 instances at a time. 
* They are bound to a specific AZ. 
  - EBS volume in attached to US-EAST1 cannot be attahed to US-EAST2
  - To move a voluyme accross, you need to snapshot it. 
* Its like a network drive 
  - It uses network to communiocate
  - it can be detached from and EC2 instance and attached to another instance
* You have to provide capcity
  - You can ncrease opr decrease it. 
  - 

## Delete on Termination 
When an EBS is enabled to be deleted on termination, it means what when the instance is terminated, the EBS Volume will also be terminated. 

# EBS SNAPSHOT 
* This is  a backup of the EBS volume. 
* When you have a snapshot of an EBS volume, you dont' have to deatch the volume to snapshot 

## EBS Snapshot Feature 
1. EBS Snapshot Archive 
2. Recycle Bin for EBS Snapshots (Set up rules to retain deleted snapshot)
3. Fast Snapshot Restore
   
## EBS RECYCLE BIN 
* It protects amazon EBS snapshot ans Amaxon Machine Image (AMI)
* When a snapshot is deleted it goes to the Recycle Bin

# AMAZON MACHINE IMAGE
* This is a custimization of EC2 instance.
* AWS has several AMI but you can also customize your own AMI.
* AMI are built for a specific region 
  
* You can Launch ec2 instance from:
1. AWS provided AMI 
2. Your customize AMI 
3. AWS marketplace AMI (Where you can find AMI created by someon else)

## EC2 INSTANCE STORE
* EBA Volumes are elike network drives with good but liiteed performancne.
* EC2 Instance store gives high-performance hardware disk usage
* It cannot be used as a durable long term place.
* Becasue when an EC2 instance is terminated the instance store will be lost.
  

## EBS VOLUME TYPES 
1. gp2/gp3 - Genneral purpose volume 
              Balances price and performance for a wide varity of workload

2. io1/io2 - Hisgest performace volume 
             Mission critical low latency 


## Amazon EFS (Elastic File System)
* EFS is a manged NFS that can be mounted on many EC2 instances
* EFS woorks with EC2 instances thatin multi AZ 
* It highy avalaible, expensive, pay as use. 
* Use security grouip to control access to your EFS 
* It uses NFSva.1 protocol 
* EFS only support Linux AMI

## EFS STORAGE CLASSES 
1. Storage Tier: Moves files to a diffrent tier after a few days(Move files from EFS standard to EFS-IA) 
      * EFS Standard: Frequently used files are located here.
      * EFS-IA: Infrquently accessed files are moved here.
                Lower price to store files in this tier.

2. Availability and Durability
* EFS Standard Multi-AZ: EFS will be located in multiple AZ. Great for Production environment (If one AZ is not available, it will not affect the EFS) 
* One Zone:  EFS eill be locatd in just one AZ. Great for dev environment, but will nedd backup enabled by default.  
## EBS vs EFS 
* EBS VOLUMES 
1. EBS volumes is atytached to one insatnnce at a time 
2. Except multi attach (io1,io2)(ATTACH same instance in multiple instance in the same AZ)
3. EBS volumes are locked at the AZ Level 
4. gp2: IO will increase if the disk increase 
5. io1: can increase IO independently. 
6. We need to take a snapshot to migrate EBS volume accross AZ 
7. Root EBS volume ofinstance will get terminated by default when the EC2 instance is terminated. 

* EFS volumes
1. Only for linux instances 
2. Can be mounter on 100 instance across all AZ 
3. EFS is more expensive than EBS 
4. Can leverage EFS-IA for cost savings 
5. 