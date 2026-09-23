# FTP 

## 1. What Is FTP?

**FTP (File Transfer Protocol)** is a standard network protocol used to transfer files between a client and a server over TCP/IP.

- **Port 21** is the standard port for FTP.
- FTP follows a **client–server architecture**:
  - The **server** hosts and serves files — it makes files available for clients to access.
  - The **client** (e.g., FileZilla) connects to the server to request, download, or upload files/folders.
- In short: a client connects to an FTP server, browses the shared location, and can **download** files from it or **upload** files to it for others to access.


## 2. Olivine's FTP Setup

- Olivine's FTP server runs on a **Windows machine** using **Windows IIS** (Internet Information Services).
- Normally, an FTP server stores files locally. In Olivine's case, files/folders are instead stored in an **Azure Fileshare**, connected to IIS through a **virtual directory**.
- **Access management** (who can log in, and what they can do) is configured **directly on the IIS FTP server** — not on the Azure Fileshare itself.

### Users
Olivine has two types of users who need access to a shared folder (to upload, download, or browse files):
- **Internal users** — Olivine employees/systems
- **External users** — outside parties

Both internal and external users upload/download through the **Olivine Internal FTP Server** (the IIS server).

---

## 3. Virtual Directory — How IIS Connects to Azure Storage

In an FTP server, files don't have to live only on the local server disk. They can instead be stored in a separate storage location — in Olivine's case, an **Azure Fileshare** inside a storage account.

To make that remote storage accessible through the FTP server, IIS uses a **virtual directory**.

- A **virtual directory** is a *virtual folder* created inside the IIS FTP server. To a connecting client, it looks and behaves like a normal folder on the server.
- Behind the scenes, that virtual folder doesn't point to a local disk path — it points to the **actual physical path** of the file in Azure storage (i.e., the container/path inside the Azure Fileshare where the file is really stored).
- In other words: the **real file path** is a storage account path (Azure Fileshare → container → folder), but IIS maps and displays that path as a **named virtual directory**, so clients can browse and transfer files as if they were stored locally.

**Why this matters:** it decouples *where files are actually stored* (Azure Fileshare) from *how clients access them* (IIS FTP). This lets Olivine keep files in scalable cloud storage while still exposing a standard FTP interface to internal and external clients.


## 4. External FTP Servers (Not Owned by Olivine)

Some FTP servers belong to **external partners**, not Olivine — for example, **PGE**.

- Olivine's internal users sometimes need to upload/download files to/from these **external** FTP servers.
- Inside an external FTP server, there are multiple partner-specific subfolders (e.g., `sunrun`, `leap`, etc.).
- Olivine's internal users only need access to **Olivine's designated subfolder(s)** within that external server.

### Folder structure convention
Each partner folder on an external FTP server typically contains **two subfolders**:

| Folder | Purpose | Olivine Access Needed |
|---|---|---|
| `TO_OLIVINE` | Files meant to go **from partner → Olivine** | **Read** access (to download files) |
| `TO_LEAP` (or `TO_<partner>`) | Files meant to go **from Olivine → partner** | **Write** access (to upload files) |

**Example:** The `leap` folder on the PGE external FTP server contains `TO_Olivine` (read) and `TO_Leap` (write) subfolders.

---

## 5. The JOB File Transfer Platform (The "Middleman")

Since internal users constantly need to move files between the external FTP servers and Olivine's internal Azure storage, Olivine's developer/platform team built the **Olivine File Transfer Platform** — an application embedded into the main Olivine platform.

**Purpose:** Act as a middleman between:
- the **external FTP server(s)** (e.g., PGE), and
- the **internal Azure Fileshare/storage** used by Olivine.

**How it works:**
- **Downloading:** When a file needs to come from an external FTP server, the platform pulls it and saves it into the Azure Fileshare (internal storage).
- **Uploading:** When a file needs to go out, the platform takes it from the Azure Fileshare and uploads it to the correct folder on the external FTP server.

This means internal users never have to interact with the external FTP server directly — they work through the Olivine File Transfer Platform, which handles the transfer to/from external partners automatically (including via pre-built "ready-made flows").


## 5. Architecture Diagram Walkthrough

### Top half — Internal FTP flow
```
[C1: Internal Client]  ─┐
                          ├──► Olivine Internal FTP Server (IIS)
[C2: External Client]  ─┘         │  - Access Management
                                   │
                                   ▼  (via Virtual Directory)
                         Azure Fileshare (AZ Fileshare)
                                   │
                                   ▼
                    Storage Account (holds shared folders)
                    Folder → Files → Transfer
```
- Both internal (C1) and external (C2) clients connect to the same **Olivine Internal FTP Server (IIS)**.
- IIS handles login/access management directly.
- IIS reaches the actual file storage through a **virtual directory** pointing to an **Azure Fileshare**.
- The Fileshare sits inside a **storage account**, which holds the shared folders (organized as folder → files → transfer).

### Bottom half — External (PGE) flow
```
PGE External FTP Server ◄──────► Olivine File Transfer Platform (Olivine App)
        │                                      │
        ▼                                      ▼
    ┌───────────┐                    (connects back to AZ Fileshare)
    │  Leap     │
    ├───────────┤
    │ TO_Olivine│ ◄── Olivine reads (download)
    │ TO_Leap   │ ──► Olivine writes (upload)
    └───────────┘
        │
        ▼
   Ready-made flows
```
- **PGE's External FTP Server** communicates bidirectionally with the **Olivine File Transfer Platform**.
- The platform, in turn, connects to the same **Azure Fileshare** used internally — closing the loop between external partner data and Olivine's internal storage.
- Partner subfolders (like `Leap`) each contain a `TO_Olivine` (read/download) and `TO_Leap` (write/upload) folder.
- **Ready-made flows** automate the routing between `TO_Olivine` / `TO_Leap` and the internal system.

---
### Top half — Internal FTP flow
- Both internal (C1) and external (C2) clients connect to the same **Olivine Internal FTP Server (IIS)**.
- IIS handles login/access management directly.
- IIS reaches the actual file storage through a **virtual directory** pointing to an **Azure Fileshare**.
- The Fileshare sits inside a **storage account**, which holds the shared folders (organized as folder → files → transfer).

### Bottom half — External (PGE) flow
- **PGE's External FTP Server** communicates bidirectionally with the **Olivine File Transfer Platform**.
- The platform, in turn, connects to the same **Azure Fileshare** used internally — closing the loop between external partner data and Olivine's internal storage.
- Partner subfolders (like `Leap`) each contain a `TO_Olivine` (read/download) and `TO_Leap` (write/upload) folder.
- **Ready-made flows** automate the routing between `TO_Olivine` / `TO_Leap` and the internal system.

---

## 6. Quick Summary (Interview-Ready)

- FTP = client-server protocol for file transfer, standard port 21.
- Olivine's internal FTP server runs on **Windows IIS**; access control lives on IIS, but actual file storage lives in an **Azure Fileshare** connected via a **virtual directory**.
- Internal + external clients both connect through the **same internal IIS FTP server**.
- Separate **external FTP servers** (owned by partners like PGE) require Olivine users to access specific partner subfolders — each split into a **read** folder (`TO_Olivine`) and a **write** folder (`TO_<partner>`).
- The **Olivine File Transfer Platform** was built as a middleman so internal users don't touch external servers directly — it automatically downloads external files into Azure storage and uploads Azure-stored files out to external servers.





# Provision the Azure VM

- Create a Windows Server Azure VM (e.g. `Standard_D2s_v3`)
- Ensure NSG allows inbound on port `21` (FTP control) and `990` (FTPS)
- Open passive port range (e.g. `50000–50100`) for passive mode FTP

### ✅ Step 2 — Create Azure Storage Account + FileShare

- Azure Portal → **Storage Accounts** → **Create**
- Create a **FileShare** inside the storage account
- Note the Storage Account name and access key — needed for mapping

```
FileShare URL format:
\\<storageaccount>.file.core.windows.net\<sharename>
```

### ✅ Step 3 — Map Azure FileShare to the VM

Run on the Azure VM to mount the FileShare as a persistent network drive:

```cmd
net use Z: \\<storageaccount>.file.core.windows.net\<sharename> ^
    /user:Azure\<storageaccount> <storagekey> /persistent:yes
```

### ✅ Step 4 — Install IIS + FTP Feature

- **Server Manager** → **Add Roles and Features**
- Select: `Web Server (IIS)` → `FTP Server` → `FTP Service`
- Also install **FTP Extensibility** for custom auth providers

### ✅ Step 5 — Create FTP Site in IIS

- **IIS Manager** → **Sites** → **Add FTP Site**
- Set Physical Path to the mapped Azure FileShare drive (e.g. `Z:\`)
- Binding: `IP = VM IP` | `Port = 21` | `SSL = Required (FTPS)`
- Authentication: **Basic** | Authorization: **Allow specific users**
- Add `dbservice@olivineinc.com` with **Read/Write** permissions

### ✅ Step 6 — Configure Virtual Directories

Virtual Directories map FTP paths to Azure FileShare folders:

| Virtual Directory (FTP Path) | Maps To (Azure FileShare UNC Path) |
|---|---|
| `/AZ-Logs` | `\\storageaccount.file.core.windows.net\share\Logs` |
| `/AZ-FNS` | `\\storageaccount.file.core.windows.net\share\FNS` |
| `/AZ-Temp` | `\\storageaccount.file.core.windows.net\share\Temp` |

> **IIS Manager** → Right-click FTP Site → **Add Virtual Directory** → enter Alias + Physical Path (UNC)

### ✅ Step 7 — Configure Passive Mode & Firewall

- **IIS** → **FTP Firewall Support**: Set data channel port range (`50000–50100`)
- Set **external IP** of the VM for passive mode responses
- Open those ports in the **Azure NSG inbound rules**

### ✅ Step 8 — Test with FileZilla

```
Site Manager → New Site
  Host:       ftps://olivineinc.com  (or VM public IP)
  Port:       21  (or 990 for implicit FTPS)
  Protocol:   FTP
  Encryption: Require explicit FTP over TLS
  Logon Type: Normal
  User:       dbservice@olivineinc.com
```

Connect and verify you can browse `/AZ-Logs`, `/AZ-FNS`, `/AZ-Temp`


## Interview Q&A

### ❓ How did you set up FTP on Azure?

> *"I deployed a Windows Server VM on Azure and installed the IIS FTP role. Instead of using the VM's local disk for storage, I connected it to Azure Files via a persistent UNC path. I then used IIS Virtual Directories to map FTP paths like `/AZ-Logs` directly to specific FileShare folders. This made the solution durable and scalable — the files survive even if the VM is reimaged."*

---

### ❓ Why use Azure Files instead of attaching a data disk?

> *"Azure Files gives us shared access — multiple VMs or on-prem machines can mount the same share simultaneously. It also decouples storage from compute, so scaling or replacing the VM doesn't affect the data. And Azure Files integrates with Azure Backup natively."*

---

### ❓ What is a Virtual Directory in IIS and why did you use it?

> *"A Virtual Directory in IIS is an alias that maps a URL or FTP path to a physical folder — local or a UNC network path. I used them to map `/AZ-Logs` and `/AZ-Temp` to Azure FileShare folders. This lets users see a clean FTP folder structure while the actual data lives in Azure cloud storage."*

---

### ❓ How did you secure the FTP server?

> *"I configured FTPS (FTP over TLS) to encrypt the connection, restricted NSG rules to only allow FTP ports from known IP ranges, used a least-privilege service account for authentication, and stored the storage account key in Azure Key Vault rather than hardcoding it."*

---

### ❓ What would you do differently at scale?

> *"For larger scale, I'd consider Azure Blob Storage SFTP (now GA) which eliminates the need to manage an IIS VM entirely. It provides native SFTP access to Blob storage without any server management. I'd also add Azure Monitor alerts on the FTP VM's CPU and disk I/O, and implement Azure Site Recovery for the VM."*

---

## 6. Quick Reference Cheat Sheet

| Item | Value / Command |
|---|---|
| FTP Port (Control) | `21` |
| FTPS Port (Implicit) | `990` |
| Passive Port Range | `50000–50100` (configurable in IIS) |
| FileShare Mount | `net use Z: \\<sa>.file.core.windows.net\<share> /user:Azure\<sa> <key> /persistent:yes` |
| IIS FTP Feature | Server Manager → Add Roles → Web Server (IIS) → FTP Server |
| FTP Site Root | Physical path = mapped drive or UNC path to FileShare |
| Virtual Directory | IIS Manager → FTP Site → Add Virtual Directory → alias + UNC path |
| Test Client | FileZilla → Site Manager → Explicit FTPS, port 21 |
| FTP Logs Location | `/AZ-Logs` → mapped to Azure FileShare Logs folder |
| Auth Account | `dbservice@olivineinc.com` (Basic Auth in IIS) |

---

> 💡 **Pro Tip for Interviews:** Lead with the Azure Files backend angle — most candidates just say "I set up IIS FTP." Mentioning that you used Azure Files with Virtual Directories shows you understand cloud-native storage patterns, not just Windows Server basics.


