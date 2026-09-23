# Azure FTP Server (IIS)

## Azure Cloud Engineer | olivineinc.com Environment
1. What Is FTP?
FTP stands for File Transfer Protocol. It is a standard network protocol used to transfer files between a client and a server over a TCP/IP network.

## Concept	Description File Transfer Protocol
* Purpose = Transfer files between client and server
* Port = 	21 (commands) | 20 (data)
* Secure Variant = FTPS (FTP over SSL/TLS) — port 990
* Common Client	FileZilla (free, cross-platform)
* Common Server	IIS FTP on Windows Server / Azure VM


2. Architecture Overview
The diagram below describes the full architecture of the Azure-hosted FTP solution deployed in the olivineinc.com environment.

2.1 Architecture Diagram 
Remote User (FileZilla)
        |
        | FTPS connection (port 990 / 21)
        v
  [ FTP Server — IIS on Azure Windows VM ]
        |                    |
        |                    v
  [oeservice@olivineinc.com ]   [ AZ-FileShare (Azure Files) ]
   (FTP Auth Account)                    |
                             [ Azure Storage Account ]
                                         |
              [ Virtual Directories mapped via IIS ]
              /AZ-Logs   /AZ-FNS   /AZ-Temp

3. Component Breakdown of the Azure Resource 
* FTP Client (FileZilla) => The FTP client — a user connecting from outside using the FileZilla app
* FTP Server => (IIS VM)The Azure VM running IIS (Internet Information Services), which hosts the FTP service
* AZ-FileShare => An Azure Files share (cloud-based SMB/NFS file storage) connected to the VM
* Storage Account   => The Azure Storage Account that backs the FileShare
* oeservice@olivineinc.com  => An FTP user/account used to authenticate to the FTP server
* Virtual Directories	=> IIS Virtual Directory config	=> Maps FTP paths to Azure FileShare UNC paths

## Connection flow:

A remote user with FileZilla connects to the FTP server at something like ftps://olivineinc.com
The FTP server (IIS on Azure VM) authenticates them
* Files are stored in the Azure FileShare, which maps to a folder on the VM


## Virtual Directories 
This is where it gets into IIS configuration detail:

Virtual Directories — IIS lets you map a folder path  to an Azure File Share folder. So when FTP users browse to /FolderName, it actually reads from the Azure FileShare URL:

  http://<storageaccountname>.file.core.windows.net/<FolderName>

* E.G
AZ-Logs — Azure Logs is a vitual dictory 

Mapped to: \\storageaccount.file.core.windows.net\Logs



Key Takeaway
The diagram is teaching how to:

Set up an IIS-based FTP server on an Azure Windows VM
Use Azure File Shares (instead of local disk) as the backend storage for FTP directories
Map those shares as Virtual Directories in IIS
Allow remote users to connect via FileZilla (FTP client) using credentials like dbservice@olivineinc.com
Capture FTP logs stored back in Azure storage