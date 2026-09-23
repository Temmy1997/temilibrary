# CLOUDFRONT 
1. Cloudfront is a content delevery network 
2. It improves read performce by caching the content of the website at diffrent edge locations.
3. It speeds up the distribution of your static and dynamic web content to users around the world.
4. Improves user's experinces 
5. Its a global service 


## ORIGINS OF CLOUDFRONT
1. S3 BUCKETS 
* Distributing files and caching files 
* Used to upload files in s3 

2. CUSTOM ORIGIN (HTTP) 
* Application load balancer 
* EC2 instnace 
* S3 website 
* Any HTTP backend  

## Cloudfront vs Cross region replication 
CLOUD FRONT 
* It achieves this by caching content at edge locations, which are geographically closer to users.
* Uses global edge network 
* Files are cache in each edge location (maybe for a day) 
* Great for static content that must be avaliable everywhere 

S3 CROSS REPLICATION 
* CRR is a feature of Amazon S3 that automatically replicates objects between S3 buckets in different AWS regions.
* Must be set up for each region you want replication to happen 
* No caching of file, because files are updates in real time 
* It read only 
* Great for dynamic content that needs to be avaliable at low-latency in few regions. 

## CLOUDFRONT -ALB OR EC2 AS AN ORIGIN 
* When using Amazon CloudFront, you have several options for your origin, the source from which CloudFront retrieves your content.

 EC2 Instances as Origin
* You can directly configure an EC2 instance as the origin for your CloudFront distribution.
* EC2 instance must be public.
* CloudFront will fetch content directly from the web server running on that EC2 instance.
* Must have a security theat alows list of all the public IP of the edge location of cloudfront.

 Application Load Balancers (ALBs) as Origin:
 * ALB distributes incoming application traffic across multiple EC2 instances within a target group.
* ALB must be public while the backend EC2 will be private. 
* Allow security group of the load balancer. 

## CLOUDFRONT -REO RESTRICTION
CloudFront Geo Restriction, also known as Geo Blocking or Geo Filtering, allows you to control which geographic locations can access your content.

* You can restrict who can access your distribution
1. Allowlist: 
A list of countries or regions that are allowed to access your content.

2. Blocklist: 
A list of countries or regions that are blocked from accessing your content.

## CLOUDFRONT -PRICING 
Because cloudfront edge locations are all around the world, the cost of data out per edge is based on the location 

** THREE PRICE CLASSWS 
1. Price classAll: All region - best performance 
2. Price class 2oo: Most region -but excludes the most expensive region 
3. Price class 100: Only the least expensive region 

## CLOOUDFRONT -CACHE INVALIDATION 
Amazon CloudFront Cache Invalidation is the process of removing objects from CloudFront's edge caches before their Time-to-Live (TTL) expires.

 * It's the action of telling CloudFront to delete specific files or all files from its edge locations.

* It's used when you've updated content on your origin server and want those changes to be immediately reflected for users.

* Normally, CloudFront caches objects for a specified TTL.

* Invalidation allows you to override this.   


** You can force an entire parctial cache refresh, by performing cloudfront invalidation. 



