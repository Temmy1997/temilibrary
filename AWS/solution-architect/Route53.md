# DNS 
* DNS is domain name system
* It translate hoatnames into IP addresses
* DNS uses hierarchical naming structure 

## DNS TERMINOLOGIES 
* Domain registrar: Amazon Route 53, GoDaddy 
* DNS records: A, AAAA, CNAME, NS
* Zone file: Contains DNS record 
* Name server: Resolved DNS queries 
* Top level Domain: .com, .us, .org, .gov 
* Second level Domain: amazon.com google.com
 
 ## Amazon Route 53 
 * It highlt available, scalable, fully managed and authoritatiive DNS(Authoritayive means that we hsve full contol over the DNS where we can update the DNS RECORDS) 
 * ROUTE 53 us a domain regristrar : we can register out own domain name in route 53  
 * Route 53 PROVIDES 100% avalability SLA 
 * Has the abulity to check the health of the reources 

## DNS RECORDS
* The DNS records defines how you want to route traffic for a domain 
* DNS RECORDS CONTAINS: 
        1. DOMAIN/SUBDOMAIN NAME: example.com 
        2. Record type : A, AAAA, 
        3. Value of the record 
        4. Routing policies
        5. How route 53 respond to queries
        6. TTL(Time to leave): Amount of time the records cached at DNS Servers 
* Route 53 support the following DNS record types:
   Must know : A, AAAA, CNAME, NS 

## RECORD TYPES
1. A - maps a hostname to ipv4 
2. AAAA - maps a hostname to ipv6
3. CNAME:   maps a hostname to another hostname
        * The target is a domain name which must have A, AAAA records 
        * Cannot create a CNAME record  for the top node oa a DNS namespace. 
        * Example.com : cant create for CNAME 
        * www.example.com: Can create for CNAME
4. NS - Name server for the hosted zone

## HOSTED ZONE 
* A container of records that defines how to route traffic to a domain and its subdomains.
* TYPES OF HOSTED ZONE
        1. Public hosted zones: 
                * Contains records on how to route traffic on the internent ( Uses public doamin name)[application.publicdomain.com]
                * It answer's query from public clioent 
        2. Private hosted zones: Contains records on how to route traffic within one or more VPC'S (Private doamin name)[application.privatecompany.internal]
Note: Any hosted zone created in AWS, you will have to $0.50 per month 

* 172.31.13.17  AZ us-west-1b

* 172-31-1-9  AZ us-east-1a
  
* 172-31-37-62 AZ us-east-2c

* Load balanacer 
Demo-route53-ALB-1632932857.us-west-1.elb.amazonaws.com

## Route 53 (TTL)
* Time to live 
  When a client send a DNS request to Amazon Route 53 the TTL will cache the result based on the time set for the TTL. 
    * High TTL: if the TTL is set to 24hrs 
            1. Less traffic on Route 53 (less client are doing requests, because the result are chse for 24 hrs)
            2. Will have possible outdate records 
    * Low TTL: if the TTL is set to 60 seconds
            1. More traffic on Route 53 
            2. Records will be outdated for less time 
            3. More moneyt is spoent 
            4. Easy to change records 

Note: TTL is manadatory for each DNS records 

## CNAME VS Alias 
1. CNAME: Points a hostanme to any other hostname 
          It's only for non-root domain 

2. Alias: 
   Points a hostanem to an AWS resoureces (hostname =  AWS Resources)
   Works for both Root and non-root doamin 

## Alias Records Target 
1. Elastic load balancer 
2. Coud front distribution 
3. API Gateway 
4. Elastic beanstalk enviromnet 
5. s3 websites 
6. VPC Interface Endpoint 
7. Global Accelartor 
8. Route 53 record in the same hosted zones 

NOTE: You cannot set an ALIAS record for an EC2 DNS name  

## HEALTHCHECKS 
* Amazon 53 health chekcs monitors the health and performance of the web application, web servers and other resources. 
* Health check monitors 
        1. Status of Amazon cloudwatch akaerm 
        2. Health check of a specifiied resource 
        3. Satus of other health checks 

TYpes of Health check 
1. Calculated health check (It uses OR, AND,NOT)

## Routing Policy 
1. Simple :
   * Route traffic to a single resource 
   * Can spsecify mutiple values in the same record 
   * A random value is chosen if multiple values are returend 
   * Can't ne associated with health checks 
 2. Weighted 
   * Controls the percentage of the request that goes to each specific resources. 
   * You can assign a weight 0 to a record to stop sending traffic to a resopurce  
 3.Latency:
  * Route traffic to the resources that has the lowest latency. 
  * Latency mneans delay 
  * Low latency will lead to posiitivce use experince while high latency will be oppiosite.  
  * Latency is measureude based on how quick is it for user tot osnect 
  * Latency is based on traffic between users an AWS Regu
4. Failover 
  * Route traffic to a resource when the resource is healthy 
  * It goes to a diffrent resource when the first resource is unhealthy 
  * 
5. GEOLOCATION 
* Routing is based on user's geographocal loication .

6. Geogroximity : 
   1. Routes traffic based on user's resource geographocal location 
   2. The only diffrence between geoproximioty and geOlocation is That (Geoproximity has the ability to route traffic more to resource based on the defined bias)
   3. Has the ability to change the size of the geographic region based on bias value 
   4. When a resource has more bias, then more traffic will be routyed to that resources. 
7. IP -bASED 
   * Route traffic based on user's IP address
   * 
8. Multi-value 
   * Route traffic to multiple resources 
   * Associated with health checks ( return only values for healthy resources)
   * Up to 8 healthy records are returned for each multi-value query 
   * 


## 3rd par domain and route 53. 
 

 #!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>Welcome to Temitope's Website</title>
</head>
<body>
  <h1>Welcome to My Website!</h1>
  <p>This is the homepage of Temitope's website.</p>
</body>
</html>
EOF

service httpd start
chkconfig httpd on
