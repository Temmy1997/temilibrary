# Cluster Maintenance OS UPGRADE 

The time a pod is expectd to come back online is called POD eviction timeout 

 * Drain node 
 kubectl drain node

 * Mark a node unschedulable 
 kubectl cordon node 

 * configure node to be schduled again 
 k uncordon node 

# Kubernetes Software Release and Version 
1. Major Version 
1.0 = July 2015 
More software verion has beenin relased as at today. 

2. Minor Version 

3. Pacth version 

# CLUSTER UPGRAGE PROCESS 
* When upgrading a clister, you upgrade the master node first before you upgrade the worker node. 

* Worker node does not get affected when the master node is upgrading. 

## Strategies in upgrading the work nodes 


# Backup and Restore Methods
1. Delecarative approach 

* IN this approach we use configuration yaml files 
* Store the yaml files in the source code repository. 

2. Query Kube-api server 
* 
3. Backup ETCD 
* It stores information about the state of a cluster
* A snapshot of the ETCD cluster can be taken and can be backed up. 
* etcdctl is a command line client for the ETCD. 
* To make use of etcdctl for tasks such as back up and restore, make sure that you set the ETCDCTL_API to 3.

## Take a snapshot of the ETCD database using the built-in snapshot functionality. Store the backup file at location /opt/snapshot-pre-boot.db

## Assignment 
​
- Host 2 websites on one apache webserver 
  - You should be able to access both websites from the same IP address.
  
- Research web application servers
  - types of web application servers 
  - try to setup a web application server 
Collapse


