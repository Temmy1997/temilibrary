# Terraform Workspaces 

## 1. The 10-second version

A **workspace** is just a **separate state file** for the **same Terraform code**.

Same `.tf` files → different workspaces → different, independent copies of your infrastructure.

Official definition: CLI workspaces are *"separate instances of state data inside the same Terraform working directory."*
    ghty. jkkii.     

   ## 3. Why should I care?

Terraform uses the **state file** to remember what it has already built. If you only have one state file and run the same code for "dev" and then "prod", Terraform thinks they're the *same thing* and will change or destroy one to match the other.

Workspaces fix that by giving each environment its own state.

The docs' main example use case: *"create a parallel, distinct copy of a set of infrastructure to test a set of changes before modifying production infrastructure."*

---

## 4. Things you get automatically

- Every initialized directory starts with **one workspace named `default`**.
- You're always in **exactly one** workspace at a time.
- The `default` workspace **can't be deleted**.

---

## 5. The commands (all of them)

```bash
terraform workspace show               # Which workspace am I in?
terraform workspace list               # Show all workspaces (* = current)
terraform workspace new dev            # Create "dev" and switch to it
terraform workspace select prod        # Switch to "prod"
terraform workspace select -or-create qa   # Switch to "qa", create it if missing
terraform workspace delete dev         # Delete "dev"
```

### Useful flags

| Command | Flag | What it does |
|---|---|---|
| `new` | `-state=path` | Start the new workspace from an existing state file |
| `new` / `delete` | `-lock=false` | Don't take a state lock (not recommended with teammates) |
| `new` / `delete` | `-lock-timeout=30s` | How long to wait for a state lock (default `0s`) |
| `select` | `-or-create` | Create the workspace if it doesn't exist |
| `delete` | `-force` | Delete even if the workspace still tracks resources ⚠️ |

> ⚠️ **`delete -force` warning:** If the workspace still has resources, they keep running in the cloud but Terraform **forgets** them ("dangling" resources). Run `terraform destroy` in that workspace **first**.
>
> You also can't delete the workspace you're currently in — `select` another one first.

---

## 6. Hands-on walkthrough

### Step 1 — Write some code (`main.tf`)

```hcl
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "hello" {
  filename = "${path.module}/hello-${terraform.workspace}.txt"
  content  = "Hello from the ${terraform.workspace} workspace!"
}
```

> This uses the `local` provider, so it runs on your laptop with no cloud account needed.

### Step 2 — Initialize

```bash
terraform init
terraform workspace show
# default
```

### Step 3 — Create dev and apply

```bash
terraform workspace new dev
# Created and switched to workspace "dev"!
terraform apply -auto-approve
# creates hello-dev.txt
```

### Step 4 — Create prod and apply the SAME code

```bash
terraform workspace new prod
terraform apply -auto-approve
# creates hello-prod.txt   (dev's file is untouched!)
```

### Step 5 — Look around

```bash
terraform workspace list
#   default
#   dev
# * prod
```

### Step 6 — Clean up

```bash
terraform destroy -auto-approve          # destroy prod's stuff
terraform workspace select dev
terraform destroy -auto-approve          # destroy dev's stuff
terraform workspace select default
terraform workspace delete dev
terraform workspace delete prod
```

---

## 7. The magic variable: `terraform.workspace`

Inside your code, `terraform.workspace` returns the **name of the current workspace**. Use it to make each environment slightly different.

### Example A — scale by environment (from the docs)

```hcl
resource "aws_instance" "example" {
  count = terraform.workspace == "default" ? 5 : 1
  # ...
}
```

### Example B — tag/name resources by environment (from the docs)

```hcl
resource "aws_instance" "example" {
  tags = {
    Name = "web - ${terraform.workspace}"
  }
  # ...
}
```

### Example C — per-environment settings with a map (common pattern)

```hcl
locals {
  settings = {
    dev  = { instance_type = "t3.micro", count = 1 }
    prod = { instance_type = "m5.large", count = 3 }
  }
  env = local.settings[terraform.workspace]
}

resource "aws_instance" "web" {
  count         = local.env.count
  instance_type = local.env.instance_type
  ami           = "ami-xxxxxxxx"
  tags          = { Name = "web-${terraform.workspace}-${count.index}" }
}
```

> 💡 Tip: with Example C, running in a workspace not in the map (e.g. `default`) causes an error — which is a handy safety net.

---

## 8. Where does the state actually live?

| Backend | Where workspace state goes |
|---|---|
| **Local** (no backend configured) | `default` → `terraform.tfstate`; others → `terraform.tfstate.d/<workspace>/terraform.tfstate` |
| **Remote** (S3, AzureRM, GCS, etc.) | Stored in the backend; the workspace name is added to the state path/key |

Example local layout after the walkthrough:

```
.
├── main.tf
├── terraform.tfstate                 # default
└── terraform.tfstate.d/
    ├── dev/terraform.tfstate
    └── prod/terraform.tfstate
```

### Backends that support multiple workspaces (per the docs)

AzureRM · Consul · COS · GCS · Kubernetes · Local · OSS · Postgres · Remote · S3

---

## 9. When NOT to use workspaces 🚩

This is the part most beginners miss. The docs are clear:

> *"Workspaces are not appropriate for system decomposition or deployments requiring separate credentials and access controls."*

In plain English:

| ❌ Don't use workspaces when... | Why |
|---|---|
| Dev and prod need **different credentials / accounts / subscriptions** | All workspaces share **one backend** and one auth setup |
| You need **strong isolation** (e.g., someone must never touch prod) | Anyone who can use dev can `select prod` in the same backend |
| You're splitting a big system into parts (network, database, app) | Each subsystem should have its **own configuration and backend** |
| Environments are **very different**, not just sizes/names | You'll end up with messy `terraform.workspace == ...` logic everywhere |

### ✅ Good fits

- Short-lived test copies (e.g., a copy per feature branch)
- Environments that are near-identical and share credentials
- Personal sandboxes and learning

### Alternatives the docs recommend

- **Reusable modules** called from **separate root configurations** (e.g. `envs/dev`, `envs/prod`), each with its **own backend**
- Share data between configurations with `terraform_remote_state` data sources, resource tags, DNS records, or a key/value store like Consul

---

## 10. Don't confuse CLI workspaces with HCP Terraform workspaces

| | **CLI workspaces** (this guide) | **HCP Terraform workspaces** |
|---|---|---|
| What it is | Extra state files in **one** directory | A full, separate working directory with its own state, variables, runs, and permissions |
| Isolation | Weak (shared backend/creds) | Strong (per-workspace settings & access) |

Same word, different thing. The docs explicitly call this out.

---

## 11. Common beginner mistakes

1. **Forgetting which workspace you're in** → always run `terraform workspace show` before `apply`. Add it to your shell prompt if you can.
2. **Using `default` as prod** → create named workspaces (`dev`, `prod`) and leave `default` unused.
3. **`delete -force` without destroying first** → leaves orphaned (still-billing) resources.
4. **Using workspaces to separate prod and dev accounts with different credentials** → use separate configs/backends instead.
5. **Committing `terraform.tfstate.d/` to Git** → add it to `.gitignore` (state can contain secrets).

---

## 12. Bonus: CI/CD tip

You can choose the workspace with the `TF_WORKSPACE` environment variable instead of running `select` — handy in pipelines (Jenkins, GitLab, Azure DevOps):

```bash
export TF_WORKSPACE=dev
terraform plan
```

Or the explicit, safe version:

```bash
terraform init -input=false
terraform workspace select -or-create "$ENV"
terraform plan -out=tfplan
terraform apply tfplan
```

---

## 13. Cheat sheet

```text
show                    → where am I?
list                    → what exists?
new <name>              → create + switch
select <name>           → switch
select -or-create <n>   → switch, create if missing
delete <name>           → remove (destroy resources first!)
terraform.workspace     → current name, usable in code
```

**One sentence to remember:**
> Workspaces = same code, separate state files. Great for near-identical copies; not a security boundary.

