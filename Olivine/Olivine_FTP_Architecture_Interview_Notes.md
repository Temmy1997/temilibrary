# Olivine FTP -- Architecture, Configuration & Troubleshooting Notes

> **Purpose:** Quick-reference study notes for understanding the Olivine
> FTP environment, troubleshooting common issues, and explaining the
> architecture confidently in a technical interview.
>
> **Important:** These notes reflect the details discussed during the
> environment walkthrough. Confirm exact server names, storage account
> names, share names, authentication settings, ports, and permissions in
> the live environment before making changes.

------------------------------------------------------------------------

## 1. Executive Summary

Olivine's FTP service is hosted on a **Windows Azure Virtual Machine**
running **Internet Information Services (IIS) FTP**.

The public FTP end/point discussed is:

``` text
ftps.olivineinc.com
```

IIS provides the FTP access layer. The actual files are stored in an
**Azure Storage Account using Azure Files / file shares**. IIS FTP
virtual directories map the directories users see through FTP to the
underlying storage locations.

The key distinction is:

-   **Azure VM + IIS:** accepts FTP connections and applies FTP
    configuration.
-   **IIS virtual directories:** map FTP directory paths to storage
    locations.
-   **Azure Files:** stores the actual files.

### Architecture at a glance

``` text
Internal employees / External customers
                 |
                 v
       ftps.olivineinc.com
                 |
                 v
       Azure Windows Virtual Machine
                 |
                 v
             IIS FTP
                 |
                 v
       IIS FTP virtual directories
                 |
                 v
       Azure Storage Account
                 |
                 v
          Azure File Shares
```

------------------------------------------------------------------------

## 2. Infrastructure Overview

  Component                         Details discussed
  --------------------------------- ---------------------------------------
  FTP endpoint                      `ftps.olivineinc.com`
  Hosting platform                  Microsoft Azure
  FTP server                        Windows Azure Virtual Machine
  Primary server region discussed   West US 2
  FTP software                      IIS FTP
  Storage service                   Azure Storage Account
  File storage                      Azure Files / file shares
  Internal authentication           Olivine Active Directory credentials
  External authentication           Local Windows accounts were discussed
  FTP client                        FileZilla
  Storage access identity           OE Service AD account was discussed

There are two FTP server deployments mentioned in the walkthrough:

-   **West US 2:** manually created.
-   **Canada Central:** created using Terraform.

The endpoint `ftps.olivineinc.com` was identified as pointing to the
West US 2 FTP server. Verify current DNS and deployment details before
relying on this in production.

------------------------------------------------------------------------

## 3. How an FTP File Request Works

1.  A user opens an FTP client, such as FileZilla.
2.  The user connects to `ftps.olivineinc.com`.
3.  IIS FTP receives the connection on the Windows VM.
4.  IIS authenticates the user using the configured authentication
    method.
5.  IIS applies the FTP site's settings, including User Isolation and
    FTP Authorization Rules.
6.  The user's FTP directory is mapped through an IIS virtual directory.
7.  The underlying storage location is accessed using the configured
    storage permissions and identity.
8.  The user lists, downloads, or uploads files according to the
    permissions granted.

**Remember:** Successful login does not automatically mean the user can
read, write, or access every directory.

------------------------------------------------------------------------

## 4. Internal and External FTP Users

### Internal users

Internal users were described as authenticating with their Olivine
Active Directory credentials.

Typical checks when an internal user cannot access FTP:

-   Confirm the user can authenticate.
-   Confirm the user belongs to the appropriate security group, if group
    membership is used.
-   Check the FTP Authorization Rules.
-   Check IIS FTP User Isolation.
-   Check NTFS permissions and the underlying Azure Files access
    configuration.

### External customers

The walkthrough described using local Windows accounts for external
customers who do not have Olivine AD accounts.

A typical setup process may include:

1.  Create the required local Windows account on the FTP server.
2.  Configure the user's FTP directory and the required directory
    structure.
3.  Confirm the FTP site's User Isolation configuration.
4.  Configure the appropriate FTP Authorization Rules.
5.  Grant the required NTFS permissions.
6.  Confirm the underlying storage mapping and permissions.
7.  Apply any required public-IP allowlisting in the relevant network
    security control.
8.  Provide the customer with connection details securely.
9.  Test login, directory listing, download, and upload as appropriate.

**Security reminder:** Do not assume every external user requires the
same setup. Follow the organization's approved access and provisioning
process.

------------------------------------------------------------------------

## 5. IIS FTP User Isolation

### What is FTP User Isolation?

FTP User Isolation is an IIS feature that restricts an FTP user to the
directory assigned to that user, based on the selected isolation mode
and the configured directory structure.

For example, multiple users may belong to the same Windows security
group but still be directed to separate FTP directories.

  User     Example group   Example FTP directory
  -------- --------------- -----------------------
  User A   FTP Users       User A's directory
  User B   FTP Users       User B's directory
  User C   FTP Users       User C's directory

The important distinction:

-   **Group membership and permissions** determine what a user is
    allowed to do.
-   **FTP User Isolation** determines the directory area the user is
    placed in or restricted to.
-   **NTFS and storage permissions** still determine whether the user
    can actually read or write the files.

Being in the same group does not automatically mean users should see one
another's folders.

### Where is User Isolation configured?

User Isolation is configured at the **FTP site level** in IIS Manager.
It is not normally configured separately on each user's account.

Navigation:

1.  Open **Internet Information Services (IIS) Manager** on the FTP
    server.
2.  In the Connections pane, expand the server.
3.  Expand **Sites**.
4.  Select the FTP site (the walkthrough referred to the site as **FTP
    Home**).
5.  In the center Features View, locate **FTP User Isolation**.
6.  Double-click **FTP User Isolation**.
7.  Review the selected isolation option.
8.  Only change it through the approved change process, then apply and
    test.

### Why configure it at the site level?

The FTP site setting establishes the isolation behavior for users
connecting to that site. IIS then applies that behavior to individual
users according to the selected mode and directory structure.

This is why an administrator can configure the site's isolation behavior
once while users still have separate directory experiences.

### Interview explanation

> "In IIS, FTP User Isolation is configured at the FTP site level. It
> controls how users are restricted to their own FTP directory. Users
> can belong to the same Windows security group and still be isolated
> from one another. The group and NTFS permissions control what actions
> they are allowed to perform, while User Isolation controls the
> directory area they access. I would also verify that the folder
> structure matches the selected IIS isolation mode."

### Important troubleshooting distinction

If a user logs in but lands in the wrong directory, check:

-   The FTP site's selected User Isolation mode.
-   The expected directory structure for that mode.
-   The user's account name and home-directory mapping.
-   The IIS virtual directory configuration.

If a user reaches the correct directory but cannot upload, check
authorization and file-system/storage permissions as well.

------------------------------------------------------------------------

## 6. IIS FTP Virtual Directories

An IIS FTP virtual directory maps a directory name exposed through FTP
to a physical path or storage location.

In this environment, the virtual directory is important because it
connects the FTP directory structure to the underlying Azure Files
location.

Conceptually:

``` text
FTP client sees:
    /CustomerFolder

IIS virtual directory maps to:
    Configured physical or network path

Underlying data is stored in:
    Azure Files file share
```

When troubleshooting a missing folder or inaccessible path, check:

1.  Does the virtual directory exist in IIS?
2.  Is its physical path or network path correct?
3.  Is the target storage location available?
4.  Does the configured identity have access?
5.  Do the FTP user and Windows permissions allow the requested
    operation?

------------------------------------------------------------------------

## 7. Permissions: Understand the Difference

FTP access can involve several permission layers. A user may pass one
layer and fail at another.

  -----------------------------------------------------------------------
  Layer                               What it controls
  ----------------------------------- -----------------------------------
  Authentication                      Whether the user can sign in

  FTP User Isolation                  Which directory area the user is
                                      placed in or restricted to

  FTP Authorization Rules             Whether FTP Read and/or Write
                                      operations are allowed

  NTFS permissions                    Windows file-system permissions on
                                      the target directory

  Azure Files / storage permissions   Whether the underlying storage
                                      access is permitted

  Network rules                       Whether the client can reach the
                                      service
  -----------------------------------------------------------------------

### Read vs. Write

-   **Read:** permits supported read/list/download operations, subject
    to other permissions.
-   **Write:** permits supported upload or modification operations,
    subject to other permissions.

A user may be able to connect and browse but still fail to upload if
Write is not allowed or the underlying file-system/storage permissions
deny the operation.

------------------------------------------------------------------------

## 8. Troubleshooting Example: User Can Connect but Cannot Upload

A customer issue discussed during the walkthrough involved a user who
could connect to FTP but could not upload files.

**Cause identified:** The relevant IIS FTP Authorization Rule was
configured as Read-only.

### Resolution steps discussed

1.  Sign in to the Windows FTP server.
2.  Open IIS Manager.
3.  Navigate to **Sites**.
4.  Select the FTP site.
5.  Select the relevant FTP virtual folder (the walkthrough referred to
    the **SC** virtual folder).
6.  Open **FTP Authorization Rules**.
7.  Select the applicable rule.
8.  Choose **Edit**.
9.  Enable **Read** and **Write**, if both are required and approved.
10. Apply the change.
11. Test the upload using the affected account.

### What to verify if the issue remains

-   The correct user or group is covered by the authorization rule.
-   The user has the required NTFS permissions.
-   The underlying Azure Files permissions allow the operation.
-   The virtual directory points to the correct location.
-   The storage path is available.
-   No other rule or security control is denying access.

**Lesson:** Being able to connect to FTP does not prove that the user
has upload permission.

------------------------------------------------------------------------

## 9. Network Access and Connectivity

For connectivity issues, investigate the path from the client to the FTP
server.

Potential areas to check:

-   DNS resolution for `ftps.olivineinc.com`.
-   The FTP server VM's availability.
-   Azure Network Security Group (NSG) rules.
-   Windows Firewall rules.
-   Any upstream firewall or public-IP allowlisting.
-   FTP control and data-channel configuration.
-   Passive FTP port configuration, if passive mode is used.
-   TLS configuration and certificate validity for FTPS.

**Do not assume a port or passive-port range.** Confirm the actual IIS
FTP and firewall configuration before troubleshooting or changing
network rules.

------------------------------------------------------------------------

## 10. Quick Troubleshooting Guide

  -----------------------------------------------------------------------
  Symptom                             First areas to investigate
  ----------------------------------- -----------------------------------
  Cannot resolve FTP hostname         DNS and client network

  Cannot connect                      VM status, firewall, NSG, FTP
                                      service, ports

  TLS/certificate error               FTPS configuration and certificate

  Login rejected                      Credentials, authentication
                                      provider, account status

  Login succeeds but wrong folder     User Isolation, directory
  appears                             structure, virtual directory

  User cannot list files              FTP Read authorization, NTFS and
                                      storage permissions

  User can download but cannot upload FTP Write authorization, NTFS and
                                      storage permissions

  Folder is missing                   Virtual directory mapping, target
                                      path, storage availability

  Multiple users see unexpected       Isolation mode, directory
  folders                             structure, permissions
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 11. Interview Questions and Suggested Answers

### Q1. Explain the Olivine FTP architecture.

**Suggested answer:**

"Olivine's FTP service is hosted on a Windows virtual machine in Azure,
running IIS FTP. Users connect through the FTP endpoint. IIS handles the
FTP connection, authentication, isolation, and authorization. IIS
virtual directories map the FTP folders to the underlying Azure Files
storage, where the actual data resides. So the VM and IIS provide the
access layer, while Azure Files provides the storage layer."

### Q2. What is IIS FTP User Isolation?

**Suggested answer:**

"FTP User Isolation is an IIS feature that restricts users to their
designated FTP directory based on the selected isolation mode and
directory structure. It is configured at the FTP site level. Users can
belong to the same security group and still be isolated into separate
directories. Group membership and file-system permissions control access
rights, while isolation controls the directory area the user accesses."

### Q3. What is the difference between FTP Authorization Rules and User Isolation?

**Suggested answer:**

"User Isolation controls where the user is placed or restricted within
the FTP directory structure. FTP Authorization Rules control whether the
user or group is allowed to perform FTP Read or Write operations. Both
need to be configured correctly."

### Q4. A user can log in but cannot upload. What would you check?

**Suggested answer:**

"First, I would check the FTP Authorization Rules to confirm that Write
is enabled for the relevant user or group. Then I would check NTFS
permissions on the target directory and the underlying Azure Files
permissions. I would also verify the virtual directory mapping and
confirm that the user is accessing the expected directory."

### Q5. Why use Azure Files with IIS FTP?

**Suggested answer:**

"IIS FTP provides the FTP access service, while Azure Files provides
shared file storage. Separating the access layer from the storage layer
allows the FTP service to expose and manage access to data stored in
Azure."

### Q6. Where do you configure FTP User Isolation?

**Suggested answer:**

"In IIS Manager, I select the FTP site under Sites and open the FTP User
Isolation feature in the site's Features View. The setting is configured
at the site level."

### Q7. What is an IIS FTP virtual directory?

**Suggested answer:**

"A virtual directory exposes a directory path through the FTP site and
maps it to a configured physical or network path. In this environment,
it helps map FTP folders to the underlying Azure Files storage."

### Q8. What would you check if an FTP user sees another user's directory?

**Suggested answer:**

"I would review the FTP site's User Isolation mode, verify that the
directory structure matches the selected mode, and check the user's
home-directory mapping and permissions. I would not assume that group
membership alone provides directory isolation."

------------------------------------------------------------------------

## 12. Quick Revision -- Before an Interview

Memorize these points:

1.  **Windows Azure VM:** Hosts the FTP server.
2.  **IIS FTP:** Provides the FTP service.
3.  **FTP endpoint:** `ftps.olivineinc.com`.
4.  **Azure Files:** Stores the actual files.
5.  **Virtual directories:** Map FTP folders to storage paths.
6.  **User Isolation:** Configured at the FTP site level.
7.  **Security groups:** Help assign permissions to users.
8.  **FTP Authorization Rules:** Control FTP Read and Write permissions.
9.  **NTFS permissions:** Control Windows file-system access.
10. **Azure Files permissions:** Control access to the underlying
    storage.
11. **Network controls:** Determine whether clients can reach the FTP
    service.
12. **Terraform:** Used to create the Canada Central FTP deployment,
    according to the walkthrough.

### One-minute interview summary

> "I understand the FTP architecture as two main layers: the access
> layer and the storage layer. The access layer is a Windows Azure VM
> running IIS FTP. Users connect through the FTP endpoint, and IIS
> handles authentication, User Isolation, and FTP authorization. IIS
> virtual directories map the FTP paths to Azure Files, which stores the
> actual data.
>
> One important configuration is FTP User Isolation. It is configured at
> the FTP site level and ensures users are restricted to their
> designated directories based on the selected isolation mode. Even when
> users belong to the same security group, they can still have separate
> directory access. When troubleshooting, I check authentication, User
> Isolation, FTP Authorization Rules, NTFS permissions, storage
> permissions, and network connectivity."

------------------------------------------------------------------------

## 13. Details to Confirm in the Live Environment

These notes intentionally do not guess settings that were not fully
established during the walkthrough. Confirm the following before making
production changes:

-   Exact Windows VM names for both regions.
-   Exact Azure Storage Account and file-share names.
-   Exact IIS FTP site and virtual-directory names.
-   The selected FTP User Isolation option.
-   The actual FTP directory structure.
-   The authentication provider and identity used for each user type.
-   The exact storage identity and permissions used by IIS.
-   Whether the service uses explicit FTPS and which TLS settings are
    enabled.
-   FTP control port and passive data-port range.
-   Current NSG, Windows Firewall, and public-IP allowlisting rules.
-   Whether the endpoint has failover or load-balancing behavior.

------------------------------------------------------------------------

**Study tip:** Practice explaining the architecture without reading the
notes, then use the interview questions to test yourself. Focus
especially on the difference between User Isolation, FTP Authorization
Rules, NTFS permissions, and Azure Files permissions.
