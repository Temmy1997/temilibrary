## SNOW FAMILY 
* It represent an highly secured portable devices that collect and process data at the edge or migrate data in and out of AWS. 
* Becuse it is expensive to tranfer data over the network, then AWS Snowball device is a better way for data migration. 
* The snow family are physical offline devices tht perform data migration. 
* AWS will send the user the portablwe device to your house(post office), then you load your data into the device and send it back to AWS. 
* It is stated as a rule that if it takes more than a week to tranfer data over the network then you can use the AWS Snowball device. 

##   DATA MIGRATION  
1. Snowcone 
2. Snowball Edge 
3. Snowmobile  

##  EDGE COMPUTING 
1. Snowcones  

2. Snowball Edge 



 
 ## Diffrent types of Device Wiithin the Snow Family (DATA MIGRATION) 
1. Snowball Edge : 
 * Moves Terrabytes or Petabyesn of data dun and out of AWS
 * Pay per job tranfer 
 * Provides block storafe and Amazon S3 conpataibale object storage 

    ## Tyes of Snowball 
    A. Snowball EDge storage Optimized:
        ** 80TB of hardware disk for block volume and s3 campatible object 

    B. Snowball EDge compute Optiumized
        ** 42TB of hardware disk or 28TB 
    
2. SNOWCONES 
* SMall portable device that can withsatnd harsh environment 
* Used with envioenment that has little data 
* Snowcone (8TB of HDD STORAGE, 14TB OF SSDSTORAGE ) 
* We should use Snowcone where the snowball does not fit 
* Must provide your won battery and cables 

3. Snowmobile 
* This is a truck that tranfer data 
* It tranfers exabytes of data 
* Each snowmobile has 100 petabyes of data 
* It has high security 
* Better than Snawball, if your tranfer more than 10 Tb 

## SNOW FAMILY - USAGE PROCESS 
1. Request for the snowball devices from AWS 
2. Install the snowball client or AWS OpsHub on the server 
3. Connect the snowball to the servers 
4. STart copying th files 
5. Ship back the device to AWS when you're done 
6. Dat will be loadedin the s3 bucket 
7. Snowball will be completly wiped. 

## Diffrent types of Device Wiithin the Snow Family (EDGE COMPUTING) 
* Data is proccessed while it being created at the edge location 
* Edge Location: Is anaything that does not have internet,= (Truck on the road, ship on the sea, mining under)
For Edge computing, we will have to use and setup Snowball edge / Snowcone devices 

1. Snowcone 
* USES 2CPU, 4gb memeory, wired, or wireless access 
* USB-C power using a cord 

2. Snowball Edge devices
** Has 104 CPU, 416 gb of Ram 
** Optional GPU( For videos)
** 28TB of NVMe or 42TB HDD usable storage 

