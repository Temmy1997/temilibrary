# AWS SNOW FAMILY
The AWS Snow Family makes it easy to move large amounts of data into and out of the AWS cloud, even when internet connectivity is limited.

How It Works (Simplified):
1. Order a Device(Snowball edge device):
You order the appropriate Snow Family device from AWS.
2. Transfer Your Data:
You connect the device to your local network and transfer your data onto it.
3. Ship the Device:
You ship the device back to AWS.
4. AWS Uploads Your Data:
AWS uploads your data from the device to your specified AWS services (like S3).

## TYPES OF SNOWBALL EDGE DEVICES 
1. SNOWBALL EDGE STORAGE: Provides massive storage capacity for large-scale data migration and local backups.

2. SNOWBALL EDGE COMPUTE: Offers powerful computing resources for local data processing and analysis.

## SNOWBALL INTO GLACIER
AWS Snowball doesn't directly transfer data into Amazon S3 Glacier.

* You must use Amazon S3 furst, in cimbination with S3 lifecycle policy to transition that data into Glacier. 

BREAKDOWN PROCESS 
1. You order a Snowball device.
2. transfer your data onto the Snowball device.
3. then ship it back to AWS.
4. AWS then uploads the data into your specified S3 bucket.
5. Create a lifecycle policy that moves objects from S3 Standard (or another S3 storage class) into S3 Glacier or S3 Glacier Deep Archive after a specified period.


# Diffrent types of Device Wiithin the Snow Family (DATA MIGRATION) 
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
