# AWS STORAGE GATEWAY 
AWS Storage Gateway is a hybrid cloud storage service that allows your on-premises applications to seamlessly use AWS cloud storage.

 It enables you to connect your on-premises applications to AWS storage services like S3, Glacier, and EBS.

* Its the bridge betwen on-premises and cloud data 

## Why Use AWS Storage Gateway?
1. Disaster Recovery: Backiong up on-premises date to the cloud for diaster recovery. 
2. Backup and restore: Expnading storage from on-premises to the cloud. 
3. Data Archiving: It enables you to archive infrequently accessed data to cost-effective cloud storage like S3 Glacier.

## Types of Storage Gateway
### Amazon S3 File Gateway
- Ideal for storing and accessing files in S3 from on-premises applications
- Configured S3 buckets are accessible using NFS and SMB protocol.
- Not the entire s3 bucket will be on the file gateway.
- Most recently used files is cached in the file gateway. 
- Trasition to S3 Glacier using lifecycle policy .
- To access bucket, you need to create IAM roles for each file gateway.

### FSx File Gateway
- Provides native access to AMAZON FSx for Windows file server
- Local cache for frequently accessed  data 
- It has been discontinued by AWS 

### Volume Gateway
- Presents your cloud storage as block storage volumes (iSCSI).
Comes in two modes:
    - Cached Volumes: Frequently accessed data is cached on-premises for performance, while all data is stored in S3.   

    - Stored Volumes: All data resides on-premises, and backups are taken to S3.

### Tape Gateway
- Presents your cloud storage as a virtual tape library (VTL).
- Backup using physical tapes. 
- Store virtual tapes in Amazon S3 using iSCSI-VTL, and store archived tapes in Amazon S3 Glacier Flexible Retrieval or Amazon S3 Glacier Deep Archive.

## How It Works (Simplified):

- Deploy the Gateway:
You deploy the Storage Gateway VM on the on-premises infrastructure.   
- Configure the Gateway:
You configure the gateway to connect to your AWS storage services.
- Access Cloud Storage:
Your on-premises applications access the cloud storage through the storage gateway using standard storage protocols.   
- Data Transfer:
The gateway handles the data transfer between your on-premises applications and AWS storage.   
