# AMAZON S3 SECURITY 

S3  ENCRYPTION

This is a crucial security feature that protects your data at rest (when it's stored on S3 servers) and in transit (when it's being transferred to and from S3).

## Server-side Encryption (SSE)
- S3 encrypts your objects at rest before saving them to disk.
- When you retrieve the objects, S3 decrypts them automatically.
There are three options for SSE:

##### SSE-S3 (Server-Side Encryption with Amazon S3-Managed Keys):
    1. Encryption using keys owned, handled and managed by AWS.
    2. Enabled by default for new bukets and objects.
    3. Objecrs is encryoyed at the server-side.
    4. Encryption type is AES-256


##### Server-Side Encryption with KMS 
    1. Encryption using keys owned, handlded and managed by AWS KMS (Key management service)
    2. KMS Advanatage: Can be control by the user , Use cloud trail to audit key uasge 
    3. Must set header ""x-amz-server-side-encryption": "aws.kms"
        4. Objects is encrypted server side
   
    NOTES:
        Using SSE-KMS may be impacted by KMS limits
        When ypu uplaod, it calls the "GenerateDatakey" KMS API 
        When you download it calls the derpty KMS API 

#### Amazon S3 Encryption - SSE-C (Server-Side Encryption with Customer-Provided Keys)

        1. You provide your own encryption keys outside the AWS.
        2. This gives you the most control but requires you to manage the keys yourself.
        3. It's  a server-side encryption 
        4. Amazon S3 does not store the encryption key 
        5. We use HTTPS 
   
 ## Client -side encryption
 Encryption at the object level.  
    1. You encrypt your objects before uploading them to S3.
    2. S3 stores the encrypted data without decrypting it.
    3. You are responsible for managing the encryption keys.
    4. This is useful for situations where you want encryption to occur before data ever leaves your control.

        
## Encryption in Transit (SSL/TLS)
* This protects data while it's being transferred to and from S3.
* S3 supports HTTPS (TLS) for secure data transfer.
* Always use HTTPS when interacting with S3.


## S3 Default Encryption
* SSE-S3 encryption is autotmatically applied to new objects stores in s3 bucket
* Default encryption is on by default with SSE-S3 encryption, but it can be changed and a bucket policy can be made to force encryption to the oen you wnats.



## CORS (Cross-Origin Resource Sharing)
* Origin = scheme (Protocol) + host(domain) + port 
* This is a security feature that controls which websites are allowed to access resources (like files) stored in your S3 buckets. 
* Cross-Origin Resource Sharing (CORS) defines a way for client web applications that are loaded in one domain to interact with resources in a different domain.  

NOTE: 
CORS is an HTTP-headrer that allows a server to indicate any origin (domain, scheme, and port) other than its own. 

* CORS in S3 is a web browser security that allows you to enable images, assets, files being retrived from one S3 bucket, in case the request is origination from another origin. 
* It allows browser to display content which a web server requested from a diffrent origin. 
* 

## AWS S3 MFA DELETE 
This is a security feature that adds an extra layer of protection against accidental or malicious deletion of your S3 objects.
* MFA forces users to genrate a code on a device before doing important operation in S3. 
#### MFA WILL BE REQUIRED WHEN YOU WNAT TO DO DANGEROUS OPERATION LIKE: 
1. Permanetly delete an object veriosn 
2. Suspend versioning on the bucket 

#### MFA WONT'T BE REQUIRED WHEN YOU WNAT TO 
1. Enable Versioning 
2. List deleted versions.

NOTE:

    To use MFA DELETE, versioning must be enabled on the bucket. 
    Only the bucket owner (AWS ROOT ACOUNT) can enable/disbale MFA delete. 

## S3 Access Logs 
It provide detailed records of requests made to an S3 buckets. 

It's like a security camera recording every interaction with your data.

* Any request made to S3 from another account will be logged as a file into another s3 bucket. 
* The target logging bucket must be in the same AWS region. 
* Never set the logging bucket to be the monitored bucket, or esle it will create a LOGGING LOOP. 


## S3 Pre-signed URLS
Amazon S3 Pre-signed URLs are a powerful way to grant temporary access to objects in your S3 buckets without requiring AWS credentials. 

* Pre-SIGNED url is a URL created to temporarily access to a file/object  to download or upload
* Pre-signed URL is genrated using S3 Console, AWS CLI or SDK 
* The URL has an expiration 
    * S3 Console - 12 hours 
    * AWS CLI - 168hours 

How Pre-signed URLs Work (Simplified):
1. Generate a PRE-SIGNED URL for the speciifc object you want people to have access too.
2. Share the URL with the target user. 
3. The user accesses the object by clicking the URL.
4. S3 verifies the URL's signature and expiration time.
5. If the URL is valid, S3 grants the user access to the object.

## S3 Glacier Vault lock 
Amazon S3 Glacier Vault Lock is a feature designed to enforce compliance and data retention policies by locking down your S3 Glacier vaults.

Adopts Write-Once-Read-Many (WORM)
- An object is put in the S3 Glacier Vault preventing the object from being deleted or modified.

        * To set up this, we will have to create a vault lock policy.

        * Lock the policy for future edit.

## S3 OBJECT LOCK 
- Versioning must be eneabled
- It adopts the WORM (Write-Once-Read-Many) MODEL.
- This lock is at the object level. 

## S3 ACCESS PIONT 
* They are named network endpoints attached to an S3 bucket that you can use to perform S3 operations.

* They allow you to define specific access policies for each access point, controlling who can access what and how.

* Access point simplify security managment in s3 
* Each access pint will have its own DNS NAME 

## S3 OBJECT LAMBDA 
Amazon S3 Object Lambda allows you to add your own code to S3 GET requests to modify and process data as it's being retrieved from S3. 

* It lets you run a Lambda function to dynamically transform data as it's being fetched from S3.

* The original data in your S3 bucket remains unchanged; the transformations are applied only during retrieval.


## How to create s3 buckets and upload files
* AWS CLI provides two tiers of commands for accessing Amazon S3:
1. s3 – High-level commands that simplify performing common tasks, such as creating, manipulating, and deleting objects and buckets.
2. s3api – Exposes direct access to all Amazon S3 API operations which enables you to carry out advanced operations.

## Create S3 bucket
aws s3 mb s3://temi1997-bucket --region us-east-1 --profile temi.user