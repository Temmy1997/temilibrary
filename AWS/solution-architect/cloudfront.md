# CLOUDFRONT 
1. Cloudfront is a content delevery network 
2. It improves read performce by caching the content of the website at diffrent edge locations.
3. Improves user's experinces 
4. Its a global service 


## ORIGINS OF CLOUDFRON 
1. S3 BUCKETS 
* Distributing fils and caching files 
* Used to upload files in s3 

2. CUSTOM ORIGIN (HTTP) 
* Application load balancer 
* EC2 instnace 
* S3 website 
* Any HTTP backend  

## Cloudfront vs Cross region replication 
1. CLOUD FRONT 
* Uses global edge network 
* Files are cache in each edge location (maybe for a day) 
* Great for static content that must be avaliable everywhere 

2. S3 CROSS REPLICATION 
* Must be set up for each region you wnat replication to happen 
* No caching of file, because files are updates in real time 
* it read only 
* Great for dynamic content that needs to be avaliable at low-latency in few regions. 

## CLOUDFRONT -PRICING 
1. Because cloudfront edge locations are all around the world, the cost of data out per edge is based on the location 

** THREE PRICE CLASSWS 
1. Price classAll: All region - best performance 
2. Price class 2oo: Most region -but includes the most expensive region 
3. Price class 100: Only the least expensive region 

## CLOOUDFRONT -CACHE INVALIDATION 
When there is a back-end update Cloudfront edge location does not know about it and   will only get a refreshed content aftter the TTL expired 

** You can force an entire parctial cache refresh, by performing cloudfront invalidation. 


## Unicast & Anycast 
1. Unicast Ip : One server holds one ip address .( Thers is only one reciever){one-to-one communications}

2. Anycast IP: All servers, will hold the same ip address and the clients will be routed to the nearest one. (Traffic will be reiceived by the nearest receiver in the groups of the receivers that has an IP addreess)


## AWS GLOBAL ACCELRATOR
* AWS global accelerator uses the anycast Ip concept.
* Leverage the AWS internal network to route to the applications 
* It send traffic directly to to the closeset edge locatiion. 
The edge location sends trafficv to the application. 

* It works with Elastic Ip, EC2, ALB, NLB, public and private IP 


 ## AWS GLOBAL ACCELRATOR Vs CLOUDFRONT (SImilarities)
 1. Both uses AWS global network and its edge locations around the world. 
 2. Both services integrate withe AWS sheild for DDos protection 

 ## AWS GLOBAL ACCELRATOR Vs CLOUDFRONT (Diffrences)
 CLOUDFRONT 
 1. Cloudfront improves performance for both cachable content (images and videes)
 2. The content will be served from the edge location( The edge location has cached the content from the main server)
 3. 

AWS GLOBAL ACCELRATOR 
1. Improves the performance for a wide rnage of application over TCP OR UDP 
2. No caching avaliable 
AWS GLOBAL ACCELRATOR and ALB are AWS service that can help you to assign a static IP address and provide low latency across the globe?