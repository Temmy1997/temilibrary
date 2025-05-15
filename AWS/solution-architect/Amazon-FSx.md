# Amazon FSx
FSx allows you to launch 3rd party high-performane file systems on AWS. 

* FSx is like RDS , but for FILESYSTEMS .
* FSx allows you to launch and use file systems
without having to manage the underlying infrastructure.

## EXAMPLE OF THE FILESYSTEMS ARE:

Windows File Server
Lustre
NetApp ONTAP
OpenZFS

### Amazon FSx for Windows File Server:
1. fully managed Microsoft Windows file system.
2. Supports the SMB protocol.
3. Ideal for Windows-based applications that require shared file storage.
4. Can also be mounded on linux EC2 instances 


### Amazon FSx for Lustre
1. The name Lustre is from "Linux and "Cluster
2. This file system is for large- scale computing. 
3. It has the ability to handle massive amounts of data at very high speeds.
4. It is well suited for machine learning, high-performance computing (HPC), and media processing.
5. It can integrate with Amazon S3, allowing you to easily move data between object storage and high-performance file storage.
6. It offers different deployment options ("scratch" and "persistent") to optimize for cost and durability

    #### FSx File System deployment options 
        1. Scratch File System:
        - For Temporary storage 
        - Data will not be replicated if underlying server fails.

        2. Persistent File System 
        - For long term storage.
        - Data is replicated within the same AZ.
        - That means if the underlyign server fails, the data will be replicated withing minutes. 



### Amazon FSx for NetApp ONTAP
1. AWS managed NetApp ONTAP file system.
2. File system is compatible with (NFS,SMB.iSCSI protocol)
3. IT Works with (Linix,WINDOWS, MacOS, VMware cloud, EC2, EKS, ECS, AWS WORKSPACE)
3. Storage automatically shrink or groow 
4. Snapshot replication, low cost , compression and data dupilcates
5. It has support for point-in-time istantaneous cloning (helps to testing new workload)

### Amazon FSx for OpenZFS
1. AWS managed FSx for OpenZFS
2. Compatible only with NFS protocol in mutiple versions (v3,v4,v4.1,4.2)
3. IT Works with (Linix,WINDOWS, MacOS, VMware cloud, EC2, EKS, ECS, AWS WORKSPACE)
4. Snapshot, replication, low cost , compression 
5. It has support for point-in-time istantaneous cloning (helps to testing new workload)
    
    {Imagine you want to test a new recipe, but you don't want to mess up the original one. With FSx for OpenZFS, you can create an instant "clone" of your files}

    {This clone is like a perfect copy that you can experiment with. If you make a mistake, you can just delete the clone without affecting the original.}


