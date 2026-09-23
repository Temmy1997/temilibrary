# Terraform Providers — My Notes  

---

## 1. The one-sentence version

A **provider** is the plugin that lets Terraform actually talk to a specific service — AWS, Azure, GCP, GitHub, Kubernetes, whatever — by translating your `.tf` config into real API calls.

Terraform's core (the `terraform` binary itself) doesn't know anything about AWS or Azure. It only knows the generic language (resources, variables, state, the graph). **Providers are what teach it the specifics of a given platform.**

---

## 2. Mental model

Think of Terraform core as a universal remote control, and each provider as the code that teaches the remote how to talk to one specific brand of TV. The remote (`terraform`) knows the buttons exist (`plan`, `apply`, `resource`, `data`), but the AWS provider is what knows *how* `aws_instance` actually turns into an EC2 API call, and the Azure provider knows how `azurerm_virtual_machine` turns into an Azure Resource Manager call.

Every `resource` and `data` block you write belongs to some provider. The provider is what supplies:
- The list of resource types you can create (`aws_instance`, `azurerm_resource_group`, `google_compute_instance`, etc.)
- The list of data sources you can read
- The authentication method to reach that platform's API

---

## 3. Declaring which providers you need

Two parts to this, and people mix them up:

**Part 1 — `required_providers` (which plugin, which version)**, usually inside a `terraform` block:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

- `source` = where to download it from (`hashicorp/aws` means the official one published by HashiCorp on the Terraform Registry). Some are published by third parties, e.g. `datadog/datadog`.
- `version` = a version constraint, so Terraform doesn't silently pull in a breaking major version update.

**Part 2 — `provider` block (how to configure/authenticate it)**:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

This is where region, credentials, or other provider-specific settings go. `required_providers` says "I need this plugin"; `provider` says "and here's how to set it up."

---

## 4. Where credentials actually come from

The `provider` block usually does **not** hardcode secrets. Most providers pull credentials from the environment automatically:

- AWS provider → reads `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` env vars, or your `~/.aws/credentials` file, or an IAM role if running on AWS infra.
- Azure provider (`azurerm`) → uses Azure CLI login (`az login`), a service principal, or managed identity.
- GCP provider (`google`) → uses `gcloud auth`, a service account key file, or workload identity.

You *can* hardcode credentials directly in the `provider` block, but it's a bad practice (secrets end up in your `.tf` files and in state) — environment-based auth is the standard approach.

---

## 5. Installing providers — `terraform init`

Terraform doesn't ship with every provider bundled in. The first time you run:

```bash
terraform init
```

it reads your `required_providers` blocks, downloads the matching plugin binaries from the Terraform Registry (or wherever `source` points), and writes a **lock file**: `.terraform.lock.hcl`.

- The lock file pins exact provider versions/checksums so everyone on the team (and CI) gets the identical plugin, not just "something matching `~> 5.0`."
- **Commit `.terraform.lock.hcl` to version control.** Don't commit the `.terraform/` directory itself (that's the downloaded binaries — regenerable via `init`).

---

## 6. Multiple configurations of the same provider — `alias`

Sometimes you need the *same* provider configured two different ways in one config — classic example: deploying to two AWS regions at once.

```hcl
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_instance" "primary" {
  # uses the default (unaliased) provider — us-east-1
  ami           = "ami-123"
  instance_type = "t3.micro"
}

resource "aws_instance" "secondary" {
  provider      = aws.west   # explicitly uses the aliased one — us-west-2
  ami           = "ami-456"
  instance_type = "t3.micro"
}
```

Without `alias`, a second `provider "aws" {}` block would just conflict. `alias` lets you name extra configurations and point specific resources at them with `provider = aws.west`.

---

## 7. Providers and modules

This tripped me up at first: **modules don't declare their own provider configuration** by default — they inherit it from whatever calls them. A child module typically just declares which providers it *needs* (via `required_providers`), and the parent config passes in the actual configured provider.

For the simple case (one default provider config), it just flows down automatically. For the multi-region/aliased case, you pass providers explicitly:

```hcl
module "app" {
  source = "./modules/app"
  providers = {
    aws = aws.west
  }
}
```

This tells the module "when you say `aws`, use my `aws.west` configuration."

---

## 8. Where providers live in the bigger picture

Tying back to the other block types:

- `terraform { required_providers { ... } }` → **what** plugins this config needs, and which versions
- `provider "aws" { ... }` → **how** to configure/authenticate that plugin
- `resource "aws_instance" "web" { ... }` → **what** to actually create, using that provider
- `data "aws_ami" "latest" { ... }` → **what** to read/look up, using that provider

Every resource/data source name is prefixed by its provider for a reason — `aws_instance` is unambiguously "the `instance` resource type from the `aws` provider."

---

## 9. Common gotchas / things to remember

- Forgetting to run `terraform init` after adding a new provider — Terraform will error saying the provider isn't installed.
- Mixing up `required_providers` (version/source) with `provider` (configuration) — you usually need both, they do different jobs.
- Hardcoding credentials in a `provider` block instead of using env vars/CLI auth — avoid this, it leaks secrets into files and state.
- Forgetting `.terraform.lock.hcl` in version control — without it, teammates/CI can silently drift onto different provider versions.
- Assuming a child module automatically gets a *different* provider config than the parent — it doesn't, unless you explicitly pass `providers = { ... }`.
- Version constraint symbols worth knowing: `=` exact, `>=`/`<=` bounds, `~>` "pessimistic" (allows patch/minor bumps but not the next major — e.g. `~> 5.0` allows `5.1`, `5.9`, but not `6.0`).

---

## 10. TL;DR

A **provider** is the plugin that translates generic Terraform config into real API calls for a specific platform (AWS, Azure, GCP, GitHub, etc.). You declare *which* one and *what version* in `required_providers`, *configure* it (region, auth) in a `provider` block, download it with `terraform init`, and every `resource`/`data` block you write belongs to one provider whose name prefixes the resource type. Multiple configurations of the same provider are handled with `alias`, and modules inherit provider configuration from their caller unless you explicitly pass one in.


