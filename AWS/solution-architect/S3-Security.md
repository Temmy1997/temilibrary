## Ecrypt Bucket using these methods
1. Server-side Encryption (SSE)
   ##  Amazon S3-Encrption (SSE-S3) 
         1. Encryption using keys owned, handlded and managed by AWS
         2. Objects will be encrypted server side 
         3. Encryption typ eis AES-256
         4. Enabled by default for new bukets and objects 
         5. 
    ## Server-Side Encryption with KMS 
        1. Encryption using keys owned, handlded and managed by AWS KMS (Key management service)
        2. KMS Advanatage are ; Can be control by the user , Use cloud trail to audit key uasge 
        3. Must set header ""x-amz-server-side-encryption": "aws.kms"
        4. Objects is encrypted server side
   
        NOTES:
        Using SSE-KMS mahy be impacted by KMS limits
        When ypu uplaod, it calls the "GenerateDatakey" KMS API 
        When you download it calls the derpty KMS API 

    ## Amazon S3 Encryption - SSE-C
        1. Encryption using keys owned, handlded and managed by customers outside the AWS 
        2. Ita a server-side encryption 
        3. Amazon S3 does not store the keuy 
        4. We use HTTPS 
   
 2. Client -side encryption
 Encryption at the object level.  
        1. We will use the client libraries (Amazon S3 Client-side Encryption Library)
        2. Client will encrypt data before sendind ti to amazon S3 
        3. Client will decrypt data beforen retriving to amazon S3
        4. Customer will fully manage the keys. 

## Encryption in Transit (SSL/TLS)

## S3 Default Encryption
* SSE-S3 encryption is autotmatically applied to new objects stores in s3 bucket
* Default encryption is on by default with SSE-S3 encryption, but it can be changed and a bucket policy can be made to force encryption to the oen you wnats.



## CORS (Cross-Origin Resource Sharing)
* Origin : scheme (Protocol) + host(domain) + port 
* If a client makes cross-origin request on a S3 bucket, we will need to enable the correct CORS headers. 

NOTE: 
CORS is an HTTP-headrer that allows a server to indicate any origin (domain, scheme, and port) other than its own. 

* CORS in S3 is a web browser security that allows you to enable images, assets, files being retrived from one S3 bucket, in case the request is origination from another origin. 
* It allows browser to display content whichb a web server requested from a diffrent origin. 
* 

## S3 MFA DELETE 
* MFA forces users to genrate a code on a device before doing important operation in S3. 
* MFA WILL BE REQUIRED TO DO 
1. Permanetly delete an object veriosn 
2. Suspend versioning on the bucket 

To user MFA DELETE, versioning must be enabled on the bucket. ONly the bucket owner can enable/disbale MFA delete. 

## S3 Access Logs 
1. Use to log all access to S3 buckets 
2. Any request made to S3 from another account will be logged as a file into another s3 bucket. 
The target loggint bucket must be in the same AWS region. 
3. Never set the loggint bucket to be the monitored bucket, oresle it will create a logging loop 


## S3 Pre-signed URLS
1. Pre-SIGNED url is a URL created to temporarily access to a file/object  to download or upload
2. Pre-signed URL is genrated using S3 Console, AWS CLI or SDK 
3. The URL has an exoiration 
    * S3 Console - 12 hours 
    * AWS CLI - 168hours 

## S3 Glacier Vault lock 
1. Lock the glacier vault to adopt WORM (write Once Read ,mamy ) MODEL 
2. We will need to cretae a vauly lock policy 
This policy is at the buket level

## S3 Objetct Lock 
1. To enable S3 OBJECT LOCK, we must first enable versioning. 
2. Adopt the WORM (write Once Read ,mamy ) MODEL.
3. This lock is at the object level. 

## S3 ACCESS PIONT 
1. Access point simplify security managment in s3 
2. Each access pint will have its own DNS NAME 

## S3 OBJECT LAMBDA 
1. 

## How to create s3 buckets and upload files
* AWS CLI provides two tiers of commands for accessing Amazon S3:
1. s3 – High-level commands that simplify performing common tasks, such as creating, manipulating, and deleting objects and buckets.
2. s3api – Exposes direct access to all Amazon S3 API operations which enables you to carry out advanced operations.

## Create S3 bucket
aws s3 mb s3://temi1997-bucket --region us-east-1 --profile temi.user