# STORAGE

## Storage in DOCKER 
1. Storage driver
 Dockers stores all its data in /var/lib/docker by default. 
 It helps mamanges storgae on images and container 

2. Volume drivers 
Volume are handles by thr volume driver plugin 

## Container storage interface 
It allows storage providers to develop a plugin (CSI driver) that can be used by container orchestration systems to manage persistent storage for containers.

## Persistent Volume:
Persistent Volume (PV) is a piece of storage in the cluster that has been provisioned by an administrator or dynamically provisioned using a StorageClass

## How to create a Persistent Volume

apiVersion: v1
kind: PersistentVolume
metadata:
  name: p-volume
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: slow
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /tmp
    server: 172.17.0.2

## Persistent Volume Claim:
* Persistent Volume Claim (PVC) is a resource that allows a user to request a specific amount of storage. 
* PVCs are used by applications or pods to claim storage resources provided by Persistent Volumes (PVs). 
* Users (developers or applications) create a Persistent Volume Claim, specifying the desired storage capacity and access modes (e.g., ReadWriteOnce, ReadOnlyMany, ReadWriteMany).
* When a PVC is created, Kubernetes looks for an available Persistent Volume (PV) that satisfies the criteria specified in the PVC (capacity, access modes, etc.).
*  If a suitable PV is not available, and dynamic provisioning is enabled, Kubernetes may dynamically provision a new PV that matches the PVC requirements.

## How to create Persistent Volume Claim:

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: example-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi

## k get persistentvolumeClaim
Note: 
1. Once you create a PVC use it in a POD definition file by specifying the PVC Claim name under persistentVolumeClaim section in the volumes section like this: 

## torage class in kubernetes 
* StorageClass is an abstraction that defines the properties and provisioner for dynamically provisioned Persistent Volumes (PVs).  
* It allows users to request storage without needing to manually create PVs
