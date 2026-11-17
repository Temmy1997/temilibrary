# Terraform Import: Beginner Notes


## What is import?

You have things in your cloud **that were NOT made by Terraform**. Someone clicked them together in the AWS console, or used a script.

Terraform doesn't know about them. **Import = telling Terraform "this existing thing is yours now, start managing it."**

After an import, Terraform will track that resource in its **state**, and you can change or delete it with Terraform like anything else.


## The two things every import needs

| Thing | What it means | Example |
|---|---|---|
| **Address** | *Where* it goes in your code: `resource_type.name` | `aws_vpc.main` |
| **ID** | *Which* real thing in the cloud | `vpc-123654789` |

### Where do I find the ID format?

Open the resource's page in the provider docs (Terraform Registry) and scroll to the **"Import"** section at the bottom. It tells you what ID to use.

- `aws_vpc` → the VPC ID (`vpc-...`)
- `aws_instance` → the instance ID (`i-...`)
- `aws_s3_bucket` → the bucket name

Most common resources can be imported. If a resource page has **no Import section**, that resource can't be imported.

---

## Two ways to import

Option 1: `terraform import` **command** | 

| Style | Old way. You type a command.
| Shows a plan first? | ❌ No. It changes state right away


Option 2: `import` **block** |
New way (Terraform 1.5+). You write it in code.
Normal `plan` → `apply`
How many at once? -- As many as you want 
✅ Can write the code for yo u. 

---

## Option 1: The `terraform import` command (old way)

### Syntax

```bash
terraform import ADDRESS ID
```

### Example

```bash
terraform import aws_vpc.main vpc-123654789
```

More examples from the docs:

```bash
terraform import module.foo.aws_instance.bar i-abcd1234   # resource inside a module
terraform import 'aws_instance.baz[0]' i-abcd1234         # resource that uses count
```

### Steps

1. **Write an empty or partial resource block first**. The command needs somewhere to put it:
   ```hcl
   resource "aws_vpc" "main" {
     # fill in later
   }
   ```
2. **Run the import command.** Terraform looks up the real VPC and **adds it to the state file**. It does **not** write any code.
3. **Fill in the resource block** so it matches the real VPC (CIDR block, tags, etc.):
   ```hcl
   resource "aws_vpc" "main" {
     cidr_block = "10.0.0.0/16"
     tags = {
       Name = "main-vpc"
     }
   }
   ```
4. **Run `terraform plan`.**
   - ✅ **"No changes"** = your code matches reality. Done.
   - ❌ **Shows changes** = your code doesn't match yet. Fix the code and plan again until it says no changes.

### Problems with the command

1. It **edits state directly** with no plan to review first.
2. It does **one resource at a time**. 100 resources means 100 commands.
3. It **doesn't write the code** for you.

---

## Option 2: The `import` block (new way ✅)

### Basic syntax

```hcl
import {
  to = aws_vpc.main          # the address (where it goes in your code)
  id = "vpc-123654789"       # the real resource ID
}
```

- The keyword is `import`, with **no labels** after it.
- `to` and `id` are required.

### All arguments


| `to` | 
  Required - ✅ Yes 
  The resource address in your code 

| `id` |
 Yes (or `identity`) 
 The real resource's ID. Must be known at plan time. |
| `identity` | Alternative to `id` | For resources identified by several values instead of one ID. You can't use both `id` and `identity`. |
| `provider` | Optional | Which provider configuration to use (e.g. a second AWS region with an alias) |
| `for_each` | Optional | Import many resources of the **same type** with one block |

### Example: using `provider`

```hcl
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

import {
  provider = aws.west
  to       = aws_vpc.west_vpc
  id       = "vpc-0abc123"
}
```

### Example: using `for_each` (import several at once)

```hcl
locals {
  buckets = {
    logs   = "my-company-logs"
    backup = "my-company-backup"
  }
}

import {
  for_each = local.buckets
  to       = aws_s3_bucket.this[each.key]
  id       = each.value
}

resource "aws_s3_bucket" "this" {
  for_each = local.buckets        # the resource block must use for_each too
  bucket   = each.value
}
```

Rules:
- The resource block in `to` must **also** use `for_each`.
- Everything in one `for_each` import must be the **same resource type**.
- For **different types**, write several `import` blocks. They all run in the same plan.

### Where to put import blocks

Any `.tf` file works. HashiCorp suggests a separate **`imports.tf`** file, or putting each one next to its resource block.

---

## Steps with the import block

### Path A: you write the resource code yourself

1. Add the `import` block.
2. Add a matching `resource` block.
3. Run `terraform plan`. It shows something like **"1 to import, 0 to add, 0 to change, 0 to destroy."**
   - If it shows changes, fix your code and plan again.
4. Run `terraform apply`. The resource is now in state.

### Path B: let Terraform write the code for you

1. Add **only** the `import` block (no resource block).
2. Run:
   ```bash
   terraform plan -generate-config-out="generated.tf"
   ```
3. Terraform creates `generated.tf` containing the resource block with its **best guess** of every setting.
4. **Review and clean up `generated.tf`**. Remove settings you don't need and fix anything wrong.
5. Run `terraform plan` again and make sure it shows no unexpected changes.
6. Run `terraform apply`.

**Rules for `-generate-config-out`:**
- The file **must not already exist**. Give it a new file name or you get an error.
- It is **experimental**. The generated code can be wrong or messy, so always review it.
- Sometimes it generates **conflicting settings**. Terraform still writes the file but shows an error. Delete the conflicting line and plan again.
- If no `provider` block exists for that provider yet, add one and run `terraform init` first.

If you **skip** `-generate-config-out` and don't have a resource block, `plan` just tells you the resource block is missing.

---

## The goal every time: "no changes"

Whichever method you use, the finish line is the same:

> **`terraform plan` should import the resource with ZERO changes to it.**

If the plan wants to **change** or **replace** the resource, your code doesn't match reality yet. **Don't apply.** Fix the code and plan again.

---

## Command vs. block

| Question | `terraform import` command | `import` block |
|---|---|---|
| Where is it? | Typed in the terminal | Written in a `.tf` file |
| Review before it happens? | No | Yes (plan) |
| Multiple resources? | One per command | Many at once |
| Generates code? | No | Yes, with `-generate-config-out` |
| Works in CI/CD and code review? | Awkward | Yes, it's just code in a pull request |
| Future | Likely to be deprecated someday | The preferred way |

---

## Summary

**Import means taking something that already exists in the cloud and making Terraform manage it. The old way is the `terraform import` command: one resource at a time, no preview. The new way is the `import` block: written in code, previewed with `plan`, can do many at once, and can even write the resource code for you. Either way, keep fixing your code until `plan` shows no changes, then `apply`.**

## Links

- Import overview: https://developer.hashicorp.com/terraform/language/import
- `import` block reference: https://developer.hashicorp.com/terraform/language/block/import
- Generating configuration: https://developer.hashicorp.com/terraform/language/import/generating-configuration
- `terraform import` command: https://developer.hashicorp.com/terraform/cli/commands/import
