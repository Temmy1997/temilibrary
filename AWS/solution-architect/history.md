# AWS CLOUD HISTORY 

- Launched in 2002
- Amazon infractructure is one of their core strength, idea to market 2003 
- Luanched first service publicly with SQS in 2004
- Re-launched publicly with SQS, S3, EC2 2006 
- Launched in Eunrope 2007 


# AWS REGIONS 

AWS has regions all around the world 
- A region is a cluster of data center 
- Most AWS services are region-scooped 

Q: How do you choose AWS REGIONS 
A: IT DEPENDS ON THE FOLLOWING REASONS 
    1. Compliance:
        - Legal requirement and data governance 
        e.g: A company has a requirement that their data does not leave a particular region.

    2. Proximity:
        - Customer reduced latency 

    3. Avaliable service:
        - Not all region have all the services available.
        - Check if the gion has the services that you need 
    
    4. Pricing
        

# Avalability Zone (AZ)

- Each region will have many az.
- Min is 3, max is 6 
e.g: us-east-1a
     us-east-1b
     us

- You can have multiple data center in an avalabilty zone
- Each AZ is seperated from each other. 
- Which makes it isolated from diasters. 
- AZ are connected with high bandwidth and ultra-low latency networking (which means is very fast)

