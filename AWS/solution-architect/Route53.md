# DNS - Domain Name System. 
- It translate human friedly hostnames to IP address. 
- www.google.com => 172.217.18.36
- DNS is the backbone of the internet.

## DNS TERMINOLOGIES 
- Domain Registrar: Amazon ROUTE53 ,GoDaddy.
- DNS Records: A, AAAA, CNAME, NS 
- Zone file: Contains all the DNS records  {Matches the hostnames to ip addresss}
- Name Server: Resolves DNS queries 
- Top Level Domains: This is the last part of a domain name (e.g., .com, .org, .net)
- Second Level Domain: This is the second part of a domain name { amazon.com, google.com}
- FQDN (Fully Qualified Domain Name): This is the complete domain name, including all parts of the hierarchy (e.g., www.example.com).

 ## Amazon Route 53 
 * It highly available, scalable, fully managed and authoritatiive DNS (Authoritayive means that we hsve full contol over the DNS where we can update the DNS RECORDS) 
 * ROUTE 53 use a domain regristrar : we can register our own domain name in route 53  
 * Route 53 PROVIDES 100% avalability SLA 
 * Has the ability to check the health of the reources 

## DNS RECORDS
* The DNS records defines how you want to route traffic for a domain 
* DNS RECORDS CONTAINS: 
        1. DOMAIN/SUBDOMAIN NAME {example.com}
        2. Record type : A, AAAA, 
        3. Value of the record 
        4. Routing policies {How route 53 respond to queries}
        6. TTL(Time to leave): Amount of time the records cached at DNS Servers 
* Route 53 support the following DNS record types:
   Must know : A, AAAA, CNAME, NS 

## RECORD TYPES
1. A - maps a hostname to ipv4 
2. AAAA - maps a hostname to ipv6
3. CNAME:   maps a hostname to another hostname
        * The target is a domain name which must have A, AAAA records 
        * Cannot create a CNAME record  for the top node oa a DNS namespace. 
                EXAMPLE:
                1. You cant create a CNAME for example.com, 
                2. but can create a CNAME records for www.example.com}
4. NS - Name server for the hosted zone (DNS names or IP address of the servers that can respond to the DNS queries for the hosted zones)

## HOSTED ZONE 
* Hosted zone is like a container that holds all the DNS records for a specific domain.
* A container of records that defines how to route traffic to a domain and its subdomains.
* TYPES OF HOSTED ZONE
        1. Public hosted zones: 
                * These are for domains that are accessible to the public internet (like your website).
                * Contains records on how to route traffic on the internent ( Uses public doamin name)[application.publicdomain.com]
                * It answer's query from public clioent 
        2. Private hosted zones: 
                * These are for domains used within a private network, such as a Virtual Private Cloud (VPC) in AWS.
                * Contains records on how to route traffic within one or more VPC'S (Private doamin name)[application.privatecompany.internal]
Note: Any hosted zone created in AWS, you will have to $0.50 per month 

* 172.31.13.17  AZ us-west-1b

* 172-31-1-9  AZ us-east-1a
  
* 172-31-37-62 AZ us-east-2c

* Load balanacer 
Demo-route53-ALB-1632932857.us-west-1.elb.amazonaws.com

## Route 53 (TTL)
* Time to live 
* TTL is a value that determines how long a DNS record is cached.
  When a client send a DNS request to Amazon Route 53 the TTL will cache the result based on the time set for the TTL. 
    * High TTL: if the TTL is set to 24hrs 
            1. Less traffic on Route 53 (less client are doing requests, because the result are cached for 24 hrs)
            2. Will have possible outdate records 
    * Low TTL: if the TTL is set to 60 seconds
            1. More traffic on Route 53 
            2. Records will be outdated for less time 
            3. More money is spent 
            4. Easy to change records 

* How it Works in Route 53:
- When you create a DNS record in Route 53, you set a TTL value for that record.
- When someone tries to access your website, their computer's DNS resolver asks Route 53 for the website's IP address.
- Route 53 provides the IP address along with the TTL value.
- The DNS resolver then stores (caches) that IP address for the duration specified by the TTL.
- If someone else tries to access your website during that TTL period, the DNS resolver can use the cached IP address, which is much faster than asking Route 53 again.
- Once the TTL expires, the DNS resolver must ask Route 53 for a fresh IP address.

Note: TTL is manadatory for each DNS records 

## CNAME VS Alias 
1. CNAME: It points one domain name to another domain name.
          Think of it as saying, "This name is another name for that one.
          It's only for non-root domain like subdomains (temi.domain.com)

2. Alias: 
          Points a domain to an AWS resoureces (hostname =  AWS Resources)
          Works for both Root and non-root doamin (example.com , temi.example.com)
          It free 
          It has a native health check within it. 
          Alias record is always type A/AAAA (ipv4or ipv6)


## Alias Records Target 
1. Elastic load balancer 
2. Coud front distribution 
3. API Gateway 
4. Elastic beanstalk enviromnet 
5. s3 websites 
6. VPC Interface Endpoint 
7. Global Accelartor 
8. Route 53 record in the same hosted zones 

## NOTE: You cannot set an ALIAS record for an EC2 DNS name  

## Route 53 ROUTING  POLICY
* It control how your website's traffic is directed.

1. Simple
* It directs/route traffic to a single resource.
* Useful for simple websites with one server.
* Can specify mutiple values in the same record 
   * A random value is chosen if multiple values are returend 
* Can't be associated with health checks 
        * If multiple values are returend, a random one will be chosen by the client.

2. Weighted 
        * Allows you to distribute/route traffic across multiple resources.
        * You assign "weights"(percentage) to each resource, so you can control the percentage of traffic that goes to each.

3. Latency
Directs traffic to the resource with the lowest latency (the fastest response time). 
  * Latency mneans delay 
  * Low latency will lead to posiitivce use experince while high latency will be oppiosite.  
  * Latency is based on traffic between users an AWS region
  * This helps improve website performance for users around the world.

4. Failover 
  * Route traffic to a resource when the resource is healthy 
  * Allows you to set up a primary and secondary resource.
  * If the primary resource becomes unavailable, Route 53 automatically directs traffic to the secondary.
  * It goes to a diffrent resource when the first resource is unhealthy 
  
5. GEOLOCATION 
* Directs traffic based on the geographic location of your users.
* Useful for serving different content to users in different regions.
* Can be associated with health checks. 

6. Geogroximity : 
* Routes traffic based of your resource based on the geograpical location of the users and resources. 
* The only diffrence between geoproximioty and geolocation is that (Geoproximity has the ability to route traffic more to resource based on the defined bias)
* "Bias" allows you to either expand or shrink the geographic area from which traffic is routed to a specific resource.
* It helps to shift traffic from one region to another by increasing the bias of the region you want more traffic to routet to that region. 
* When a resource has more bias, then more traffic will be routed to that resources. 

        ## How Bias Works:

                1. A positive bias expands the geographic area that directs traffic to a resource.   
                2. A negative bias shrinks that area whi h reduces the traffic to a resource.
                3. Essentially the bias allows you to manipulate the perceived distance between the user and the resource.

7. IP-based Routing 
   * Route traffic based on user's IP address

8. Multi-value Routing 
   * Route traffic to multiple resources 
   * Associated with health checks ( return only values for healthy resources)
   * Up to 8 healthy records are returned for each multi-value query 


## HEALTHCHECKS 
* Amazon 53 health chekcs monitors the health and performance of the web application, web servers and other resources. 
* Health check monitors 
        1. Status of Amazon cloudwatch akaerm 
        2. Health check of a specifiied resource 
        3. Satus of other health checks 



 

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
