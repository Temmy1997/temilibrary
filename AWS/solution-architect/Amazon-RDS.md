# Amazon RDS
* RDS styands for Relational Datbase Service 
* It is managed database service for DB that uses SQL as a query language 
* It allows you to create datbase in the cloud that are managed by AWS 
* Types od DB 
  1. Postgres
  2. MySql 
  3. MariaDB 
  4. Oracle
  5. Microsoft SQL Server
  6. Aurora(AWS Database)

## ADV of RDS 
* Provisiosnal of database is wutomated 
* Continuous backups of database
* It has a monitoring dashboard 
* MultiAZ setup for disaster recovery
* Scaling capability (Vertical or horizontal)
* Stirage backed by EBS (gp2 or iol)
* Cant SSH into the instannes 

## RDS Read Replica 
* Helps to scale the reads 
* We can create up to 15 repliica 
* It can be within the AZ, Cross AZ or cross region 
* Replicationn iis ASYNC so reads are eventu  consistent 


## RDS Read REPLica -  NETWORK COST 
* Red replica withi the same region, do not have to pay 



## RDS Custom 
* RDS custome is for two database type (Oracle and Microsodt SQL)
* RDS custome gives us access to the OS and database customization
  * This helps to configiure setting s
  * Install patches
  * Enable  native features 
  * Access the undelying ec2 instance usng SSH 
* It automates setup, operation and scaling of database in AWS 
* Also deactivate Automation mode eto perform the customization (Take a database snapshot beforre you deactivate) 

## RDS vs RDS Custom
  * RDS: Entire database and OS is manageed by AWS 
  * RDS Custom: Full admin access to underlying OS and the database. (Oracle and Microsodt SQL)


## AMAZON AURORA 
* This is a proprietory technology from AWS  (IT IS NOT OPEN SOURCE)
* Postgres and MySQL are both supported as Aurora DB 
* Aurora claims 5X performance improvements over MYSQL OVER MySQL on RDS 
* Aurora claims 3X performance improvements over PostgreSQL ON RDS 
* Aurora storage atomatically grows in incremennts of 10gb - 128tb
* It has up to 15 replicas and the replicatio process is faster thene MYSQL
* Aurora cost more than RS ((20% MORE) but it motre efficeiont






## AMAZON ELASTIC CACHE 
* Elasric cach get mana naged by Redis or memcahced(Cached Technologies)
* Cache is an in mamamory databases with really high performance and low latency ( Low latency implies that there are no or almost no delays.)
* Cache helps to reduces load off databses for read intensive workload
* Helps to make your application stateless. 
* Since it's managed by AWS, it take care of the OS maintencae, patching, configurstion, monitoring, failure recovery abd backup.
* Amazon elastic cache require you to do heavy application code changes 

## Architecture for using Elactiv Cache 
 * Application will query elastic cache (Cache hit )
 * if its not available, it will get from the RDS abd store Elastic CAHCE (Cache miss)
 * Storing data in the cache will help to reduce load from the RDS datbase 


REIDIS 
* Multi-AZ WITH Auto-failover 
* Read replicas to scale reads, Have high avalability  
* Has a data durability 
* Support sets and sorted sets
* Has backup and restore 
* 
  
MEMCACHED
* no high avalability 
* No backup and restore 
* Non persistent
* Uses MULTI-NODE for partitioning (SHARDING) 

## Elastic cache security 
* Elastic cache uses IAM authentication for Redis 
* IAM policies are only usd fro AWS API -Level security 
* REDUS AUTHENTICATION
  * Password or token can be created for Redis Cluster 
  * Its an extra level of security for the cahce after the secirty group
  * Suppprt SSL flight encryption
* Memcached 
  * Supports SASL -based authentication (advanced_)

## Parrern for ELASTIC cache 
* Lazy Loading: Read data is cached 
* Write Through: Add or update data in the cache when written in DB
* Session store: STORE temporary session date is cache 
* 
* 