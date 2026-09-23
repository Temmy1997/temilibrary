## AWS GLOBAL ACCELRATOR
* It manages user traffic across multiple AWS regions, directing it to the closest and healthiest endpoint.
* It reduces latency by routing traffic over the AWS global network, which is optimized for performance.

NOTE:
#### Unicast & Anycast 
    1. Unicast Ip : One server holds one ip address .( Thers is only one reciever){one-to-one communications}

    2. Anycast IP: All servers, will hold the same ip address and the clients will be routed to the nearest one. (Traffic will be reiceived by the nearest receiver in the groups of the receivers that has an IP addreess)

* AWS global accelerator uses the anycast Ip concept.
* Leverage the AWS internal network to route to the applications 
* It send traffic directly to to the closeset edge locatiion. 
* The edge location sends traffic to the application. 

* It works with Elastic Ip, EC2, ALB, NLB, public and private IP 


 ## AWS GLOBAL ACCELRATOR Vs CLOUDFRONT (SImilarities)
 1. Both uses AWS global network and its edge locations around the world. 
 2. Both services integrate withe AWS sheild for DDos protection 

 ## AWS GLOBAL ACCELRATOR Vs CLOUDFRONT (Diffrences)
 CLOUDFRONT 
 1. Cloudfront improves performance for both cachable content (images and videes)
 2. The content will be served from the edge location( The edge location has cached the content from the main server)
3. CloudFront: Content caching.

AWS GLOBAL ACCELRATOR 
1. Improves the performance for a wide rnage of application over TCP OR UDP 
2. No caching avaliable 
AWS GLOBAL ACCELRATOR and ALB are AWS service that can help you to assign a static IP address and provide low latency across the globe?