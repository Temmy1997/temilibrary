# HCP Terraform: Beginner Notes


## What is HCP Terraform?

**HCP Terraform** is a **website run by HashiCorp that runs Terraform for you and stores your state for you.**

- **HCP** = **H**ashiCorp **C**loud **P**latform
- It used to be called **Terraform Cloud**. It was renamed **HCP Terraform** in April 2024. Same product, new name.
- Web address: **app.terraform.io**

HashiCorp's own description: it *"helps teams use Terraform together"* and *"manages Terraform runs in a consistent and reliable environment."*

### Simple comparison

| Without HCP Terraform | With HCP Terraform |
|---|---|
| Terraform runs **on your laptop** | Terraform runs **on HashiCorp's servers** |
| You set up your own S3 bucket to store state | HCP Terraform **stores the state for you** |
| Cloud passwords/keys sit on your laptop | Keys are saved in HCP Terraform as **secret variables** |
| Hard to see who changed what | Every run is **recorded with logs and history** |
| Teammates can overwrite each other | Only one run at a time; **approvals** before apply |

**Think of it like this:** Terraform on your laptop is cooking at home. HCP Terraform is a shared restaurant kitchen: one place, one set of ingredients, everyone follows the same rules, and every order is written down.

---

## What is it used for?

| Feature | Plain meaning |
|---|---|
| **Remote state** | Your state file is stored safely online, shared with your team, and older versions are kept as backups. |
| **Remote runs** | `plan` and `apply` run on HashiCorp's machines, not yours, so every run happens the same way. |
| **VCS integration** | Connect to GitHub/GitLab. Opening a pull request automatically runs a plan. |
| **Variables & secrets** | Store variable values and cloud credentials in one place, hidden from view. |
| **Approvals / access control** | Decide who can run plan, who can apply, and require someone to click "Confirm" before changes. |
| **Private registry** | A private "app store" for your company's own Terraform modules. |
| **Policies** | Rules that block bad changes, like "no public S3 buckets." |
| **Drift detection** (paid) | Warns you if someone changed infrastructure by hand outside Terraform. |

---

## The main building blocks

```
Organization  (your company or account)
   └── Project  (a folder to group workspaces, e.g. "networking")
         └── Workspace  (one set of infrastructure, e.g. "taco-wagon-dev")
```

### Workspace

HashiCorp: *"A workspace contains everything Terraform needs to manage a given collection of infrastructure."*

One workspace holds:
- the Terraform code (linked from Git or uploaded)
- variable values
- the state file and older copies of it
- the history of every run
- credentials, saved as secret variables

Usually you make **one workspace per environment**, e.g. `app-dev`, `app-staging`, `app-prod`.

> ⚠️ **Don't mix these up:** An HCP Terraform workspace is **not** the same as `terraform workspace` on the command line.
> - **CLI workspace** = several state files in the same folder (optional).
> - **HCP Terraform workspace** = a complete, separate unit with its own code, variables, state and permissions (required).

---

## 3 ways to use it (workflows)

| Workflow | How runs start | Good for |
|---|---|---|
| **VCS-driven** | Push to Git or open a pull request, and HCP Terraform runs automatically | Teams, the most common setup |
| **CLI-driven** | You type `terraform plan` / `apply` on your laptop, but the run happens in HCP Terraform | Learning; moving from local to remote |
| **API-driven** | Another tool (like a pipeline) calls HCP Terraform's API | Custom automation |

---

## How to connect your code (CLI-driven)

**Step 1: Log in**

```bash
terraform login
```
A browser opens. Create a token and paste it back into the terminal. Terraform saves it for you.

**Step 2: Add a `cloud` block to your code**

```hcl
terraform {
  cloud {
    organization = "my-org"                # your HCP Terraform organization name

    workspaces {
      name = "taco-wagon-dev"              # the workspace to use
    }
  }
}
```

- `hostname` is optional and defaults to `app.terraform.io`.
- Instead of `name`, you can use `tags` to pick several workspaces, or `project` to point at a project.

**Step 3: Initialize and run as usual**

```bash
terraform init      # connects to HCP Terraform
terraform plan      # runs on HashiCorp's servers; output streams to your terminal
terraform apply
```

> The `cloud` block **replaces** a `backend "s3"` block. You use one or the other, not both.

---

## Plans (pricing tiers)

| Plan | Who it's for |
|---|---|
| **Free** | Individuals and small teams. Includes remote runs, VCS integration, private registry, SSO. Limited to **500 managed resources** and **1 run at a time**. |
| **Essentials** | Adds more collaboration features; pay as you go |
| **Standard** | Adds governance and compliance (policy sets, audit logs, drift detection) |
| **Premium** | Enterprise features and priority support |

> Prices and limits change. Check hashicorp.com/pricing before you decide.

**Terraform Enterprise** = the same product, but you **host it yourself** on your own servers (for companies that can't use a hosted service).

---

## HCP Terraform vs. S3 backend + GitHub Actions

What you built in the CI course (S3 + GitHub Actions) does many of the same jobs by hand:

| Job | S3 + GitHub Actions | HCP Terraform |
|---|---|---|
| Store state | S3 bucket you create | Built in |
| Lock state | `use_lockfile` / DynamoDB | Built in |
| Run plan on PR | You write the YAML | Built in (VCS workflow) |
| Save plan, approve apply | You build it | Built in |
| Store secrets | GitHub Secrets | Workspace variables |
| Cost | AWS + GitHub costs | Free tier, then paid |

Both are valid. Many companies use HCP Terraform, and many build their own with S3 + CI.

---

## Summary

**HCP Terraform is HashiCorp's online service that stores your Terraform state, runs your plans and applies for you, keeps secrets safe, and lets a team work on the same infrastructure with approvals and history.**

## Links

- HCP Terraform docs: https://developer.hashicorp.com/terraform/cloud-docs
- Workspaces: https://developer.hashicorp.com/terraform/cloud-docs/workspaces
- `cloud` block settings: https://developer.hashicorp.com/terraform/cli/cloud/settings
- Get started tutorial: https://developer.hashicorp.com/terraform/tutorials/cloud-get-started
