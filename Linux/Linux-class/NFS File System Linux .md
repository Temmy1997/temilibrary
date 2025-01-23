## NFS (Network File System)
-This is used for sharing files and folders between Linux/Unix systems.
-It helps tp mount local file systema over a network and remote host 
-We can only set up file sharig between UNIX and LINUX.

# BENEFITS OF NFS
-It allows local access to remote files
-It uses standard client/server architecture for file sharing
- Configures centralized storage solutions
- Enabes users to get their data in differnt physical location
- No manual refresh needed for new files
- Can be secured with Firewalls.

## NFS SERVICES 
* portmap: Maps calls from other machines to the correct PRC services.
* nfs: Translates remote files sharing request on the local files system. 
* rpc.mountd: Responsible for mounting and unmounting of file system. 


## Important Files for NFS Configuration
* /etc/exports
    - Main configuration file of NFS.
    - All exported files and directories are found in this file at the NFS Server end.
* /etc/fstab
    - Used to mount a NFS directory on the system across the reboots. 
* /etc/sysconfig/nfs
    - Configuration file of NFS to control on which port rpc and other services are listening

## Setup and Configure NFS Mounts on Linux Server using a bash script 
1. We need at least two linux machines. 
2. Install NFS Server and NFS Client

# SETTIGN UP THE NFS SERVER 

## Install NFS server package
sudo yum update
sudo yum install nfs-utils -y 
# Start the NFS server services
sudo systemctl start nfs-server
sudo systemctl enable nfs-server
sudo systemctl status nfs-server

# Create a shared directory (nfsshare) in / to share with the client server
sudo mkdir /nfsshare

# Add the file in the /etc/exports to make the file shareable on the network

# Define the nfsshare directory
directory=/nfsshare

# Check if the directory exit 
if [ -d "$directory" ]; then
  echo "$directory exist."
else 
  echo "$directory does not exist." 
fi

# Add the directory to the export file and share it with the client IP with rw priviledge 
echo "$directory 44.204.126.54(rw,sync,no_root_squash)" | sudo tee -a /etc/exports
## no_root_squash: gives authority to the root user on the client to access files on the NFS server as root

# Restart NFS server services 
sudo systemctl restart nfs-server

# Print NFS server status
sudo systemctl status nfs-server

# SETTING UP THE NFS CLIENT
#!/bin/bash

# Install NFS server package
sudo yum update
sudo yum install nfs-utils -y
# Start the NFS server services
sudo systemctl start nfs-server
sudo systemctl enable nfs-server
sudo systemctl status nfs-server

# Check if the shares are available on the NFS server or NFS Client.
sudo showmount -e 172.31.1.124

# Create the /mnt/nfsshare directory 
sudo mkdir /mnt/nfsshare

# To temporarily Mount Shared NFS Directory on the client server 
sudo mount -t nfs 172.31.1.124:/nfsshare /mnt/nfsshare

# To verify 
sudo mount | grep nfs

# To permanently mount an NFS directory on the system across the reboots
echo "172.31.1.124:/nfsshare /mnt  nfs defaults 0 0" | sudo tee -a /etc/fstab
