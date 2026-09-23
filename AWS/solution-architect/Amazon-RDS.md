## Amazon RDS Overview 
* RDS - Relational Database Service 
* Thsi is a managed DB Service 
* It allows you to crreate databases in the cloud that are managed by AWS 
- MySQL
- MariaDB
- Oracle
- Postgres
- Aurora 
- 
### Advantages Over RDS versus deploying DB on EC2
- RDS is a managed service  (means AWS takes care of the underlying infrastucture) 
- Automated Provisioning 
- Continious backup & recovery.
- monitoring dashboards. 
- Multi AZ for Disater recovery 
- read replica for improved read performance
- RDS automates database backups
- Built-in security features (encryption at rest and in transit, security groups, and access control) 

### RDS - STORAGE AUTO SCALING 
* This allows your Amazon RDS database to automatically increase its storage capacity when it's running low on space.
* Adavanatges 
- Prevents Downtime
- Handles the increased load
- Avoid manaually scalin database storage.
NOTE: 
- YOU HAVE TO SET MAXIMUM STORAGE THRESHOLD (MAXIMUM LIMIT FOR DB STORAGE)


### RDS Read Replica VS Multi AZ 
RDS Multi-AZ Deployments: High Availability

Purpose:
- Focus on ensuring that your database is highly available. 
- If the primary databse fails, multi AZ  provides an automatic failover to a standby database. 
- It minimizes downtime 

How it works:
- It creates a synchronous copy of your database in a different Availability Zone (AZ) within the same AWS Region.
- Synchronous replication means data is written to both the primary and standby databases simultaneously.
- If the primary fails, RDS automatically switches to the standby

Key points:
- Provides automatic failover.   
- Enhances database durability.   
- Not for scaling read operations.

NOTE - Think of it as having a backup generator that automatically kicks in when the main power goes out. It's for ensuring your database stays running.


### RDS Read Replicas: Read Scaling

Purpose:
- Primarily focused on scaling read operations.
- It allows you to offload read-heavy traffic from your primary database.
- It's about improving performance.

How it works:
- Creates asynchronous read-only copies of your primary database.   
- Asynchronous replication means there might be a slight delay between changes on the primary and their appearance on the replica.
- You can direct read queries to the replicas, reducing the load on the primary.

Key points:
- Enhances read performance.   
- Can be in the same or different AZs or Regions.   
- Data replication has a slight delay.

 NOTE: Think of it as having extra checkout lines at a store. It's for handling a large volume of customers (read requests) efficiently.

Asynchronous means not happening at the same time.

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
* Is like a supercharged version of MySQL or PostgreSQL.
* It is built for CLOUD and it fullt managed by AWS. 
* This is a proprietory technology from AWS  (IT IS NOT OPEN SOURCE)
* Postgres and MySQL are both supported as Aurora DB 
* Aurora is faster then the standard MyMYSQL or PostrgeSQL.(Handles more transactiona dn rueries per second)
* claims 3X performance improvements over PostgreSQL ON RDS 
* Aurora storage atomatically grows in incremennts of 10gb - 128tb
* It has up to 15 replicas and the replication process is faster thene MYSQL
* Aurora cost more than RS (20% MORE) but it motre efficeiont.
* Up to 128 TB of autoscaling SSD storage
* Six-way replication across three Availability Zones
* Up to 15 read replicas with replica lag under 10-ms
* Automatic monitoring with failover

### Why use Amazon AURORA
1. Faster performance
2. Easily Scale database
3. Highly avaliable and durable 
4. Aurora is compatoible with MySQL & PostgreSQL 

### AMAZON aURORA 2 MAIN ENDPOINT
* Write Endpoint 
1. This endpoint direct traffic to the primary DB instance in the AURORA CLUSTER 
2. Used for wrtie operation (Inserting, updating, deleting data)
3. You can find the endpoint by using the AWS CLI  or API

* Read Endpoint
1. This endpoint distributes read only traffic amound the AURORA replicas in the cluster. 
2. It balances the read workload and inproves performances.
3. You can find the endpoint by usinf the AWS CLI  or API

 ### AWS RDS BACKUP
1. Automated backup 
  * RDS automatically do a daily full backup of the database.
  * Enabled by deafult
  * Transaction logs are backed up to Amazon S3 every 5 minutes.
  * AMazon RDS automatically create a storage volume snapshot of the entire DB instance daily
  * 1 - 35 days of retention 

 2. MANUAL DB snapshot
 * manaully trigged or done by the user. 
 * The backup can be retained as long as the user wants 

NOTE: When you stopp RDS database, you will still pay for storage.
Best practice is to create a snapshot of the database, delete the database, and you can restore the database whne you you need the database. 

### AURORA BACKUP
1. Automated backup 
* 1 - 35days backup retention period.
* Cannot be disbaled.
* You can restore your Aurora database to any point in time within your backup retention period.

2. Manual DB Snapshots
* Manually triggeder by thr user.
* The backup can be retained as long as the user wants 

### RDS & Aurora Restore Options 
1. You can restore RDS or Aurora backup into a new database 
2. Restore MySQL RDS database or MySQL Aurora dtabase from S3. 

### Aurora Database Cloning 
* This allows to create a new Aurora cluster form an existing one. 
* It faster tahn the snapshot & restore.
* Very fast and cost - effective 
* Useful to create a 'staging database" from a "production database" without causing a downtime on the production database. 

### RDS & AURORA SECURITY
1. At-rest Encryption:
    * Encrypting your data at rest using AWS Key Management Service (KMS). 
    * Data is protected even if the underlying storage is compromised} 
    * It must be defined at launch time 
    * If the main database is not encrypted, then the read replicas cannot be encrypted. 
    * To encrypt an un-encrypted database, go theough a DB snapshot & restore as encrypted. 

2. In-flight Encryption:
Enable SSL/TLS encryption to protect data in transit between the applications and the database.

3. IAM Authentication: 
You can create IAM users and roles and grant them specific permissions to perform actions on your databases.

4. Security Groups: 
Controls network access to the RDS / Aurora DB

5. No SSH available except on RDS custom 
6. Audit logs:
    * Enable audit logs to track database activity, including logins, queries, and changes to data. 
    * This helps you identify any suspicious activity and maintain compliance.

### Amazon RDS Proxy
* This is fully managed Service THAT SITS BETWEEN YHT APPLICATIONS and the RDS. 
* ItS LIKE A middle man that helps the applicatinn connects to the database mpre securely, efficeintly. 
* 
## AMAZON ELASTIC CACHE 
* Elasrtic cach get mana naged by Redis or memcahced(Cached Technologies)
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