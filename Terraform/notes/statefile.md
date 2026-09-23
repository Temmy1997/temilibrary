# Terraform State File — A Beginner's Guide

## What it is

The state file is Terraform's memory. It's a JSON file that records what infrastructure Terraform has already created and which real-world resource (by ID) each line in your config corresponds to. Terraform checks this file before every action so it knows what already exists, what changed, and what it still needs to create or delete — without it, Terraform would have no idea what it built.


Terraform's state file (`terraform.tfstate`) is a JSON file that maps the resources in your `.tf` config to the real infrastructure Terraform created. When you run `terraform apply`, Terraform doesn't re-read your cloud account to figure out what exists — it reads this file. Without it, Terraform has no memory of what it built.

Think of your `.tf` files as the *desired* state and the state file as Terraform's record of the *actual* state. `terraform plan` diffs the two to decide what to create, change, or destroy.

## Why it exists

Terraform needs state for three core reasons:

### 1. Mapping-  Cloud resources are identified by IDs (e.g. an AWS instance ID like `i-0abc123`), but your config refers to them by name (e.g. `aws_instance.web`). The state file is what links `aws_instance.web` to `i-0abc123`.

### 2. Performance - For large infrastructures, querying every cloud API on every plan would be slow. Terraform caches resource attributes in state and only refreshes what it needs.

### 3. Dependency tracking - Terraform stores metadata about which resources depend on which, so it can figure out the correct order to create, update, or destroy things.



Key fields worth knowing:

- **resources** — every resource Terraform manages, with its full set of attributes as last known (including things not in your config, like auto-generated IDs, ARNs, IPs).
- **outputs** — values from your `output` blocks.
- **serial** — increments every time the state changes; used to detect conflicting writes.
- **lineage** — a unique ID for this state's "family," used to prevent mixing unrelated state files.
- **version** — the state file format version (currently 4).

Important: the state file can contain **sensitive data in plain text** — database passwords, private keys, anything that ends up as a resource attribute. This is one of the biggest state-file gotchas for beginners.

## Local vs. remote state

By default, Terraform writes state to a local file, `terraform.tfstate`, in your working directory. This works for solo experiments but breaks down fast for teams:

- Two people applying at once can corrupt or overwrite each other's state.
- The file (with its secrets) often ends up committed to git by accident.
- There's no locking, so concurrent runs can race.

For anything beyond a personal sandbox, you configure a **remote backend** instead — S3 with DynamoDB locking, Terraform Cloud, Azure Storage, GCS, etc. Example:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-tfstate-bucket"
    key            = "prod/network.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

Remote backends give you: shared access for a team, state locking (prevents two applies running simultaneously), encryption at rest, and often versioning/history.

## Authentication
The azurerm backend supports 5 methods to authenticate to the storage account data plane:

- Microsoft Entra ID (Recommended)
- SAS Token (Not recommended for new workloads)
- Access Key (Not recommended for new workloads)
- Access Key Lookup (Not recommended for new workloads)

## State locking

When Terraform is about to write state, it acquires a lock so no other process can write at the same time. If you've ever seen `Error: Error acquiring the state lock`, that's this mechanism working — it usually means another apply is running, or a previous one crashed without releasing the lock. Not every backend supports locking (local state technically can, remote backends like S3+DynamoDB or Terraform Cloud do it properly).

## Common state commands

- `terraform state list` — list all resources tracked in state.
- `terraform state show <resource>` — show the full attributes of one resource as recorded in state.
- `terraform state mv <old> <new>` — rename/move a resource in state without destroying and recreating it (used when you refactor your config).
- `terraform state rm <resource>` — remove a resource from state without destroying the real infrastructure (Terraform "forgets" it, but it still exists in the cloud).
- `terraform import <resource> <id>` — bring an existing, unmanaged piece of infrastructure under Terraform's management by adding it to state.
- `terraform state pull` / `push` — download/upload the raw state, mainly for scripting or manual recovery.
- `terraform refresh` (or `plan -refresh-only`) — reconcile state with real-world changes made outside Terraform.
- terraform force-unlock <LOCK_ID> -  Unlock a terraform state file that is locked 

## State drift

"Drift" is when reality and state disagree — someone manually changed a resource in the AWS console, or deleted it outside Terraform. On the next `plan`, Terraform will either try to "correct" it back to your config, or, if the resource is gone entirely, propose recreating it. This is why manual changes to Terraform-managed infrastructure are discouraged.

## Rules of thumb for beginners

Never hand-edit the state file. If you must fix something, use `terraform state` subcommands, not a text editor — a malformed state file can break your ability to manage that infrastructure at all.

Never commit `terraform.tfstate` to git if you're using local state (add it to `.gitignore`). It often contains secrets and it's not something you want merge-conflicted.

Use a remote backend with locking as soon as more than one person or one CI pipeline touches the infrastructure.

Back it up. Most remote backends (S3 with versioning, Terraform Cloud) keep state history automatically, which is your safety net if state gets corrupted or a bad apply needs to be reverted.

One state file per environment/component is common practice — don't cram your entire org's infrastructure into a single state file, since a mistake or lock contention then affects everything at once.

## Quick mental model

Config (`.tf` files) = what you want.
State (`.tfstate`) = what Terraform believes exists.
Real infrastructure = what actually exists in your cloud provider.

`terraform plan` compares config vs. state (and optionally refreshes against real infrastructure) to tell you what will change. Everything Terraform does revolves around keeping these three in sync.

# Terraform `moved` and `removed` Blocks 

> Both are declarative, version-controlled replacements for old manual CLI workflows (`terraform state mv` / `terraform state rm`). They live in your `.tf` config and get picked up automatically on `plan`/`apply` — no special flags needed.

---

## `moved` block — rename/relocate without destroy+recreate

* Tells Terraform "this resource used to be at address A, now it's at address B — just update state, don't destroy/recreate."

```hcl
moved {
  from = aws_instance.web
  to   = aws_instance.app_server
}
```

**Use it for:**
- Simple resource renames
- Moving a resource into/out of `for_each` or `count` (e.g. `aws_instance.web` → `aws_instance.web["primary"]`)
- Moving a resource into a child module: `from = aws_instance.web` / `to = module.app.aws_instance.web`
- Renaming a module: `from = module.old_name` / `to = module.new_name`

**Remember:**
- The resource block must still exist under the *new* name — `moved` is just the migration instruction, not a substitute for updating the config.
- Safe to leave in place even after everyone's state has updated — Terraform just ignores it if the "from" address no longer exists in state.
- Only handles renaming — if the resource's arguments also changed, you'll get a move *and* a diff.

---

## `removed` block — drop from management without destroying

* Tells Terraform "stop managing this resource, but leave the real infrastructure alone" — the opposite of `destroy`.

```hcl
removed {
  from = aws_instance.legacy

  lifecycle {
    destroy = false
  }
}
```

**Use it for:**
- Handing a resource off to another team/tool without tearing it down
- Cleaning up config for something already deleted out-of-band (with `destroy = false` since there's nothing left to destroy)
- Splitting a monolith config into smaller ones — remove from the old config, `import` into the new one, infra never touched

**Remember:**
- Delete the actual `resource` block from your config at the same time you add the `removed` block — that's the whole point, the resource no longer exists in your config.
- `lifecycle { destroy = false }` is the key setting — without it, Terraform would still try to destroy the real resource on apply.
- Works for modules too: `from = module.old_module`.

---

## Quick comparison

| | `moved` | `removed` |
|---|---|---|
| Resource still managed after? | Yes, under new address | No |
| Real infrastructure touched? | No | No (with `destroy = false`) |
| Typical use | Rename/refactor | Decommission from Terraform's management |
| Replaces old CLI command | `terraform state mv` | `terraform state rm` |

---

*Compiled from developer.hashicorp.com/terraform documentation: Moved Block, Removed Block (Refactoring).*
