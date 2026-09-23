# 34.224.81.171
Administrator
-8FPOuJC5bY$a5tXeQ2JWtv(dFMCK@3Z

# 18.212.99.93
Administrator
&Nh8wOCb=xr48lRvJeR(fvmLro.ye.vz

192.168.0.22

# Active directory 
* Active Directory (AD) is a Microsoft technology used by companies to manage people, computers, and resources (like printers or files) on a Windows network.


## Forest: 
Forest is the top-level container or the entire AD environment. It is the highest logical structure that contains one or more domains, trees, and all their related objects.

### Think of a forest as:
* A company’s global network.
* Inside it, there can be many branches (domains)—each with its own users, computers, and security settings—but they can still communicate and trust each other because they are part of the same forest.

## A workgroup network 
* This is a small network of computers that are connected and share resources, such as printers and files. In a workgroup network, each computer has its own user accounts and controls access to its resources. 

# Domain: 
* A domain network is a network of computers that are connected and controlled by a central server called a domain controller. In a domain network, the domain controller handles user authentication and controls access to resources.

* A domain is a logical group of computers, users, and other resources that are managed as a single unit within a network.
* It helps manage everything in one place — like who can log in, what they can access, and what rules apply to their computer.


## domain controller 
* A Domain Controller (DC) is a server that runs Active Directory Domain Services (AD DS).

* A domain controller is a special server in that domain. It checks usernames and passwords when people log in, applies security rules, and makes sure everything stays in sync.
* A Domain Controller is the brain of the domain.
* It authenticates users when they log in, enforces security rules, and stores information about everything in the domain — users, computers, passwords, and policies.

## Install Active Directory Domain Services (AD DS)
1. Open Server Manager
2. Click Manage > Add Roles and Features
3. In the wizard:
4. Installation type: Role-based or feature-based
5. Server selection: Select your local server
6. Server roles: Check Active Directory Domain Services
7. Add required features when prompted
8. Click Next through Features, then click Install


## Promote Server to Domain Controller
1. In Server Manager, click "Promote this server to a domain controller"
2. Choose Add a new forest
3. Root domain name: e.g., example.local (jobskillshare.com)
4. Set the Directory Services Restore Mode (DSRM) password
5. Click Next through options (ignore DNS warning if seen)
6. Review and click Install
7. The server will restart.

## Verify Domain Creation
1. After the restart. 
2. Log in with domain\Administrator and the password you set.
3. Open Active Directory Users and Computers to manage users and groups.
4. Then you will see the domain you created. 

## 

1. Set compupter/client DNS to Point to Domain Controller
* Go to Control Panel > Network and Sharing Center
* Click Change adapter settings
* Right-click active adapter > Properties
* Select Internet Protocol Version 4 (TCP/IPv4) > Properties
* Set Preferred DNS server to the IP address of your DC (e.g., 192.168.1.10) [This will be the ip address of the domain contorller server]

2. Join the Domain
* Go to server manager 
* Click on the local server or Press Win + R 
* Find and click on the computer name.
* You'll be directed to the system properties.
* Click the "Change..." button next to the computer name
* Select Domain and enter your domain name (e.g., jobskillshare.org)
* Click OK
* Enter the domain username and password (e.g., example\Administrator)
* If successful, you’ll see:
        Welcome to the example.local domain!  
* Click OK and restart the computer

3. Log in to the Domain
* After restart:
* On the login screen, select "Other user"

Enter:
Username: domainname\username
Password: (password set in AD)

4.  To Verify Domain Join
* Go to System Properties again → it should say Domain: example.local
* Run whoami in Command Prompt — it should return example\username
* Open Active Directory Users and Computers on the DC:
* Look under Computers → your computer should appear there


## Veryify a client/computer is logged into a Domain 
Command to verify client/computer is logged into a Domain 
* whoami /fqdn

## Why Does Active Directory Need DNS?
* When you create an Active Directory (AD) server, it also requires DNS (Domain Name System) — because:

    Active Directory depends heavily on DNS to locate domain controllers and services on the network.


## How to install Active Directory management tools on your Windows Server 2019 without promoting it to a Domain Controller.

* This is exactly what system admins do when they want to manage AD remotely from another server or jump box.

✅ Step 1: Open Server Manager
Click Start
Open Server Manager

✅ Step 2: Add Features
* In Server Manager → Click Manage → Add Roles and Features
* Click Next until you reach the "Features" section
* Scroll down and find:

* Click on Remote Server Administration Tools
            → Role Administration Tools
            → AD DS and AD LDS Tools
                → ✅ Active Directory module for Windows PowerShell
                → ✅ AD DS Snap-Ins and Command-Line Tools
* Select the above tools
* Click Next → then Install

✅ Step 3: Use the AD Tools
* Once installed, you can:
* Open Active Directory Users and Computers (dsa.msc)
* Use Active Directory Administrative Center

## GROUPS 
* In Active Directory (AD), groups are used to organize users, computers, and other groups into manageable units.

### Types of Groups in AD
1. Security Groups 
* Used to assign permissions to shared resources (files, folders, printers)
* Useful for managing access control.
* Can be used for authentication and authorization 
* Can also be mail-enabled to send emails (Mail-Enabled Security Group).


2. Distribution Groups
* Used only for email distribution (usually with Microsoft Exchange or Outlook). 
* It cannot be used to control access to resources.
    * Examples of use:
    Creating a mailing list for a department
* Cannot be used to assign permissions.

## ADManager Plus?
* ADManager Plus is a web-based Active Directory management and reporting tool developed by ManageEngine.
* It offers centralized control over multiple domains within an organization 


## Windows PowerShell Integrated Scripting Environment (ISE) 
* This is a graphical host application designed for creating, running, debugging, and testing PowerShell scripts and modules. 

### Key features of Windows PowerShell ISE include:
1. Script Pane: For writing and editing PowerShell scripts with features like syntax coloring and IntelliSense.
2. Console Pane: For running commands and scripts, and viewing output.
3. Debugging Tools: Features like breakpoints and step-by-step execution for debugging scripts.
4. Show-Command window: A graphical tool to help construct PowerShell commands.
5. Add-ons: Support for extending functionality through add-ons.

## GROUP POLICY 
* Group Policy is a tool in Windows that lets IT admins manage and control what users and computers can do on the network.


## How to Deploy Software via Group Policy (GPO)
"To deploy software using Group Policy, you use a GPO to push an MSI installer to computers in an Active Directory domain. Here’s how I’ve done it:"





## How to check the operating system (OS) version and edition of a Windows Server

### Method 1: Control Panel
1. Press Win + R, type control system, and press Enter.
2. This opens the System and Security 
3. Click on system. 
View:

    Windows edition
    System type
    Processor
    Installed memory (RAM)

### Method 2: System Information
1. Press Win + R, type msinfo32, and hit Enter.
2. The System Information window opens.
Look for:
    OS Name → e.g., Microsoft Windows Server 2019 Standard
    Version → e.g., 10.0.17763 Build 17763
    System Type → x64-based PC

## How to Check Logs in the Event Viewer (Windows Server 2019 or Windows 10/11)
### ✅ Step 1: Open Event Viewer
Method 1: Using the Start Menu
* Click Start
* Type Event Viewer
* Click the Event Viewer app

Method 2: Using Run
* Press Windows Key + R
* Type: eventvwr.msc
* Press Enter

### 🗂️ Step 2: Understand the Log Categories
On the left side panel of Event Viewer, you'll see:

### 🔧 Windows Logs (Most commonly used)
* Application – Logs from apps (e.g., SQL Server, custom software)
* Security – Login attempts, account access (auditing)
* System – Windows system events (e.g., services starting/stopping, hardware errors)
* Setup – Events related to installing roles/features
* Forwarded Events – Events collected from other computers (if configured)

### 🛠️ Applications and Services Logs
More specific logs for services like Active Directory, DNS, Group Policy, etc.

### Step 3: Check a Specific Log 
Let’s say you want to check logon events:

* Click on Windows Logs → Security
* In the middle pane, look at Event ID 4624 (successful logon), 4625 (failed logon)
* Double-click an event to see detailed info

## Task Scheduler

Task Scheduler is a built-in Windows tool that lets you automate tasks to run at a specific time, when an event happens, or when a condition is met.

💡 Think of it as your computer’s reminder system or automatic assistant — it does things for you at the right time.

### Example: Run a Script Every Day at 8 PM
* Open Task Scheduler
* Click Create Basic Task (for beginners)
* Name the task: Daily Report
* Set trigger: Daily, at 8:00 PM
* Set action: Start a program
* Choose your script (e.g., C:\scripts\report.bat)
* Click Finish

Boom 💥— Task Scheduler will now run that script daily!

### Common Uses in IT/Admin Work
* Run backups	-- Start a backup script every night
* Restart apps/services	-- Restart a failed service automatically
* Maintenance	-- Clean temp/log files weekly
* Monitor logs	-- Send email if specific event log appears
* Wake up server   --- Use “Wake the computer to run this task” before updates

## System Information (also called msinfo32)

* System Information is a tool in Windows that gives you detailed technical info about your computer's hardware and software.

### When You Might Use It:
* Check how much RAM or what CPU your system has
* Find your system's BIOS version
* Get your computer name or domain info
* Troubleshoot hardware conflicts

## Computer Management

Computer Management is a central place where you can manage system tools, monitor performance, and control settings like users, storage, and services.

### Breakdown of Key Tools:
📄 Event Viewer
View logs for system events, errors, warnings

👥 Local Users and Groups
Create/delete users and groups (only on non-domain systems)

💽 Disk Management
View and manage hard drives

Create/delete/format partitions

⚙️ Services
Control background services (e.g., DNS, Windows Update)

### When You Might Use It:
* Create a new user on a local server

* Troubleshoot why a service isn't running

* View hard drives and partitions

* Check system errors using Event Viewer5

## Adding a new drive to a computer
Adding a new drive to a computer can mean one of two things:

1. 🔌 Physically installing a hard drive or SSD

2. 💻 Initializing and formatting a drive in Windows so the system can use it

###  Physically Installing a New Drive
Note: This is for desktops or servers. For laptops, drive installation is more limited.

Steps:
1. Turn off the computer and unplug it.

2. Open the case.

3. Mount the new hard drive (SATA HDD or SSD) into a free drive bay.

### Initialize & Format the New Drive in Windows
Once the drive is physically installed, you need to make it usable by creating a partition and formatting it.


1. Open Disk Management

2. Open computer management and clisk on disl management or [Press Windows + R, type: diskmgmt.msc, press Enter]
3. Look for the new disk
4. You’ll see it as “Disk 1”, “Disk 2”, etc.
        It will say: "Not Initialized"
5. Right-click the new disk → click Initialize Disk
6. Choose GPT (recommended for modern systems) or MBR (older systems)
7. Right-click the Unallocated space → click New Simple Volume

    Follow the wizard:
8. Assign a drive letter (e.g., D:, E:)
9. Choose file system: NTFS (default and best for Windows)
10. Give the drive a name (optional)
11. Click Finish

