# Amazon Elastic File System {EFS}
Amazon Elastic File System (EFS) is a fully managed, scalable, and elastic file storage service for Linux-based workloads running in the AWS cloud and on-premises. 


** It's designed for Linux-based applications that require shared file storage.

** It allows multiple EC2 instances (virtual servers) to access the same file system simultaneously.

** EFS automatically scales its storage capacity as you add or remove files.

## How It Works:

1. Create an EFS File System:
You create an EFS file system in your AWS account.

2. Mount the File System:
You mount the EFS file system on your EC2 instances.

3. Access Files:
Your applications can read and write files to the EFS file system as if it were local storage.

3. Automatic Scaling:
EFS automatically scales its storage capacity as you add or remove files.

4. Performance Modes:
You can choose performance modes that optimize your EFS for either general purpose file sharing, or for high throughput workloads.