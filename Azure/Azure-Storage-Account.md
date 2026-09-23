# Azure Storage Account
It is a secure online container in AZURE that stores and manages your data in the cloud. 


## TYPES OF DATA THAT CAN BE STORED ON AZURE STORAGE ACCOUNT 
1. Blob Storage
    Used for:
Images, Videos, PDFs, Backups, Website files

2. File Storage 
    Used to store:
Shared folders, Company network drives, SMB file sharing

* It acts Like a shared office folder in the cloud.

3. Table Storage
    Used for:
NoSQL structured data
Fast key-value storage

4. Disk Storage 
    Used for:
Virtual Machine storage
When you spin up a vm a disk is assocated with the virtual machine 
The disk are stored in the Azure Storage account

## DATA AVALABILITY 
1. LRS = Locally Redundant Storage:
Azure keeps 3 copies of the data within a single pysical data center in one region. 
* If one disk fails, other copies are still available.
    ## good for:
* Lowest cost option
* Non-critical workloads

2. ZRS = Zone-Redundant Storage
Azure keeps 3 copies of your data across multiple Availability Zones in the same region.
* If one datacenter/zone fails, data remains available from other zones.
    ## Good for:
Production workloads
Higher availability needs
Business-critical apps

3. GRS = Geo-Redundant Storage
3 copies in primary region
3 more copies in secondary paired region
* Best for disaster recovery across regions.

4. GZRS = Geo-Zone-Redundant Storage
ZRS in primary region (across zones)
Replicated to another region

* Combines zone protection + regional disaster recovery.

Best for mission-critical workloads.


How to connec a FTP SERVER TO an Azure Storage account 



https://myuploadportal2026.z13.web.core.windows.net/

sv=2026-02-06&ss=b&srt=o&sp=rwdlactfx&se=2026-05-23T02:02:05Z&st=2026-05-22T17:47:05Z&spr=https&sig=%2BY1ypA4iLnHSmcGRvSa%2B1cKiszqTVyKj%2F90KpxoYcCk%3D

