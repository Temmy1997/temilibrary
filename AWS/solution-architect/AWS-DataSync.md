# AWS DATA SYNC
* It moves large amount of data to and from 
* It automates the process of copying data between your on-premises storage to AWS, and other cloud providers,

To transfer data between on-premises or other cloud storage and AWS - need an agent

To tranfer data between AWS Storage services within the same AWS account. - no agent needed. 

### CAN SYNCHRONIZE DATA WITH:

1. Amazon S3 (all storage classes)
2. Amazon EFS
3. Amazn FSx 

* In this case, "synchronize" means to ensure that the data in your on-premises storage and the data in the specified AWS storage service are identical or consistent.

** Replication taskes are scheduled (hourly, weekly, daily).

** Keeps file permission and metadata (SMB , NFS, POSIX)

## How It Works:

1. Deploy an Agent:
You deploy a DataSync agent (a virtual machine) on your on-premises infrastructure.

2. Create a Task:
You create a DataSync task, specifying the source and destination locations (on-premises and AWS).

3. Configure Task Settings:
You configure task settings, such as data filtering, scheduling, and bandwidth throttling.

4. Run the Task:
You run the DataSync task, and the agent transfers the data to AWS.

5. Data Synchronization:
DataSync can perform incremental transfers, only copying changed files, to save bandwidth and time.

*** When there is no network capacity for datasync, use AWS SNOWCONE DEVICES.

*** AWS SNOWCONE DEVICE COMES WITH THE DATASYNC AGAENT PREINSTALL ON IT. 