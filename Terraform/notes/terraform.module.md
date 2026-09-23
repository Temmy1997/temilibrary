# Terraform Modules — My Notes (Explained Like I'm a Dummy)

 

---

## 1. What is a module, actually?

Forget the technical definition for a second. Think of a **module** as a **recipe card**.

A recipe card says "here's how to make lasagna: this many noodles, this much sauce, bake at this temperature." You can hand that card to anyone, and they can make lasagna without knowing *why* the oven needs to be at 375°F — they just follow the card.

A Terraform module is the same idea, but for infrastructure. It's a **folder of `.tf` files** that says "here's how to build a web server" (or a database, or a whole network). Instead of writing out all the server-building code every single time you need a server, you write it once, save it as a module, and then just "call" it whenever you need one — feeding it a few settings (like a recipe's ingredient amounts).

**Official definition (paraphrased from the docs):** *"A module is a collection of resources that Terraform manages together."*

That's it. A module = a bundle of resources, treated as one reusable unit.

---

## 2. Root module vs. child module (the two "levels")

Every single Terraform project already has at least one module, whether you meant to make one or not.

- **Root module** — this is just the main folder where you run `terraform apply`. It's the "entry point." You didn't have to do anything special to create it — it's automatically a module.
- **Child module** — a module that the root module (or another module) *calls* using a `module` block. Child modules can even call *other* child modules — they can be nested, like Russian dolls.

Analogy: The root module is the main recipe for a whole Thanksgiving dinner. Inside it, you might call a "mashed potatoes" child module and a "turkey" child module — each one is its own mini-recipe, but they all come together into one final meal.

---

## 3. Why bother with modules? (The "why")

1. **Don't repeat yourself.** If you need 5 identical web servers, you don't copy-paste the same 40 lines of code 5 times. You write it once as a module and call it 5 times.
2. **Standardization.** If your company always wants networking set up the exact same, safe way, you build a "networking module" once, and everyone on the team reuses it instead of everyone reinventing it (and possibly messing it up).
3. **Organization.** Big infrastructure gets messy fast. Modules let you break it into labeled, understandable chunks (like functions in code) instead of one giant unreadable file.
4. **Reuse other people's work.** Thousands of ready-made modules already exist in the public Terraform Registry for AWS, Azure, GCP, etc. Often you don't need to write one — you just borrow one.

---

## 4. How do you actually "call" a module? (The `module` block)

You use a `module` block. Here's the bare minimum:

```hcl
module "my_label" {
  source = "location-of-the-module"
}
```

- `"my_label"` — this is just a nickname *you* pick, so you can refer to this specific usage of the module later (e.g., `module.my_label.something`).
- `source` — **required**. Tells Terraform *where* to find the module's code. This is the only thing every module call must have.

### A more realistic example

```hcl
module "web_server" {
  source  = "hashicorp/consul/aws"   # where the module lives
  version = "0.1.0"                  # which version to use (only for Registry modules)

  servers = 3                        # an "input" this module accepts

  depends_on = [aws_s3_bucket.example]  # wait for this to exist first
}
```

Breaking that down:
- `source` and `version` tell Terraform *which* module and *which version* of it to grab.
- `servers = 3` is an **input variable** — a setting you're feeding into the module, exactly like ingredient amounts on a recipe card. The module itself defines what inputs it accepts (its author decided that).
- `depends_on` is optional — it forces Terraform to wait until something else is created first, in case Terraform can't automatically figure out the order on its own.

> ⚠️ Important nuance: `source` must be a plain, literal text string. You cannot use a variable or expression there — Terraform needs to know where to fetch the code before it even starts evaluating your other variables.

---

## 5. Where can a module's code actually live? (`source` types)

The `source` argument can point to several different kinds of places:

| Source type | Example | When you'd use it |
|---|---|---|
| **Local folder** | `source = "./app-cluster"` | The module lives right there in your own project, in a subfolder. |
| **Terraform Registry** | `source = "terraform-aws-modules/vpc/aws"` | A public (or private) pre-built module you're borrowing. |
| **Git repository** | `source = "git::https://example.com/vpc.git?ref=v1.2.0"` | The module lives in a Git repo, and you can pin an exact tag/branch/commit with `?ref=`. |
| **GitHub** | shorthand for a GitHub repo URL | Same idea as Git, just GitHub-specific shorthand, and supports shallow clones. |
| **Bitbucket** | similar to GitHub | Same idea, Bitbucket-hosted. |
| **Object storage (S3/GCS buckets, HTTP URLs)** | e.g. an S3 bucket URL | Module packaged and stored like a downloadable file. |

**Simple rule of thumb:** local folder = your own reusable code inside your own project. Registry = someone else already built and published it, and you just plug it in.

---

## 6. Versioning a module

If you're pulling a module from the Terraform Registry, you can (and should) pin a version, so it doesn't randomly change under you later:

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"
}
```

`version` only works with Registry sources — local folders and Git sources handle versioning differently (Git uses `?ref=` in the source string instead, as shown above).

---

## 7. Creating multiple copies of a module (`count` and `for_each`)

Sometimes you don't just want to call a module once — you want several copies of it, like 3 identical servers, or one instance per environment.

- **`count`** — good when you want N *identical* copies.
  ```hcl
  module "server" {
    source = "./modules/server"
    count  = 3
  }
  ```
- **`for_each`** — good when you want copies that are each *slightly different*, driven by a map or set (like "one server per region, each with a different name").
  ```hcl
  module "server" {
    source   = "./modules/server"
    for_each = { east = "us-east-1", west = "us-west-2" }
    region   = each.value
  }
  ```

You can only use one of `count` OR `for_each` on a given module block, never both at once.

---

## 8. Module Inputs and Outputs — how information flows in and out

**Getting information IN:** through the arguments in the `module` block. Those arguments must match **input variables defined inside the child module** — just like root-module variables, they need a value at runtime (or a `default`, which makes them optional to set from the parent).

**Getting information OUT:** through **output values** defined inside the child module. Those outputs become attributes of the module, referenced from the parent as `module.module_name.output_name`. An output can be any valid Terraform data type — string, number, list, map, object, whatever.

```hcl
module.web_bucket.bucket_arn
```

Pattern: `module.<the label you gave it>.<the output name the module defines>`

---

## 9. Module scoping — the "function" mental model (important!)

The cleanest way to think about a module: **it behaves exactly like a function** in any other programming language.

- Well-defined **inputs** (input variables)
- Well-defined **outputs** (output values)
- Everything happening **inside** is hidden from whoever calls it

This is called **module scoping**, and it's a hard wall in both directions:

- The **parent** (root module, or whatever called this module) has **zero visibility** into the child module's internal `resource` blocks, `data` blocks, or `locals` — you cannot reference them from outside, period. Try it and Terraform errors with "reference to undeclared resource/local value."
- The **child module** has **zero visibility** into the parent's variables, locals, or resources either — same error, opposite direction.
- **The only two doors between parent and child:** input variables (parent → child) and output values (child → parent). Everything else is locally scoped to whichever module it's defined in.
- **One exception:** provider configuration flows down from parent to child automatically (unless overridden with the `providers` argument on the module block) — that's the one thing that crosses the wall without going through inputs/outputs.

### Worked example

Root module has a variable `prefix`. Child module creates an S3 bucket. The child **cannot** reach into the root and grab `var.prefix` directly — even though it's "right there" one file up. It has to be explicitly passed in as an input variable.

```hcl
# Root module
variable "prefix" {
  type = string
}

module "web_bucket" {
  source        = "./modules/s3-bucket"
  bucket_prefix = var.prefix        # the only way to hand "prefix" into the child
}
```

```hcl
# Child module (./modules/s3-bucket)
variable "bucket_prefix" {          # must be explicitly declared here to receive it
  type = string
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_prefix}-data"
}

output "bucket_arn" {               # the only way to hand data back to the root
  value = aws_s3_bucket.this.arn
}
```

```hcl
# Back in root module, using what came out of the child
resource "aws_iam_policy" "read_bucket" {
  policy = jsonencode({
    Statement = [{
      Resource = module.web_bucket.bucket_arn   # reading the child's output
    }]
  })
}
```

If you tried referencing `var.prefix` directly inside the child module (skipping the `bucket_prefix` variable), Terraform throws a syntax/reference error — in the child's scope, `var.prefix` simply doesn't exist. Likewise, trying to reference `aws_s3_bucket.this` directly from the root module (skipping the `bucket_arn` output) fails — that resource doesn't exist in the root's scope.

**Bottom line:** if it's not an input variable or an output value, it cannot cross the module boundary — no matter how "obviously available" it looks from the other side.

---

## 10. What a well-organized module folder looks like

The official docs describe a "standard module structure" — basically a recommended set of files so that any Terraform user (or Terraform's own tooling) can open your module and immediately know what's going on.

**Minimal module = just these 4 files:**

```
my-module/
├── README.md       ← what this module does & how to use it
├── main.tf         ← the actual resources
├── variables.tf    ← the inputs this module accepts
└── outputs.tf      ← the info this module hands back
```

**A bigger, more complete module might add:**

```
my-module/
├── README.md
├── LICENSE
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/            ← nested/child modules live here
│   └── nested-thing/
└── examples/           ← example usages, for humans reading the repo
    └── basic/
```

A couple of specific rules from the docs worth remembering:
- The **root module** (top-level folder) is the only truly *required* piece — everything else is organizational best practice.
- Every variable and output should have a short `description` — one or two sentences explaining what it's for. Future-you (and your teammates) will thank you.
- Nested modules that include their own `README.md` are treated as "public" (meant for others to call directly); nested modules *without* a README are considered internal implementation details.

---

## 11. Providers inside modules 
- The root modules use where the provider instances are defined using the provider block. 
- Normally, a module just inherits the provider configuration (e.g., which AWS account/region) from whoever calls it — you don't have to think about it. This is also the one exception to module scoping (see section 9).

- If you have multiple instances of a provider in your root module, you can control which instance the child module uses by adding the providers arguments to the module block. 

### E.G:

provider "aws" {
  region = "us-east-1"
}                              # <- no alias = this is "the default" AWS connection

sxazQ 1
}                              # <- a third connection, nicknamed "security"

```hcl
module "second_region" {
  source = "./modules/server"
  providers = {. .tg,vm 
    aws = aws.west
  }
}
```
* You can only have one unaliased ("default") instance per provider. Any extras need an alias nickname to tell them apart.

There are 2 wys tp pass provider in your terraform code 
1. Implicit inheritance — the "lazy/automatic" case

If a child module uses aws_instance or any other aws_* resource, and you don't tell it otherwise, it just automatically uses the default (unaliased) connection from the root module. You don't have to do anything — Terraform quietly hands it down for you. 

2. Explicit inheritance — when you want a different one

What if you want a child module to use the security connection instead of default? You explicitly map it in the module block using providers = { }:
---

## 12. Types of modules — three different angles

**By hierarchy (where it sits in your config):**
- **Root module** — the folder you run `terraform apply` from. Every config has exactly one.
- **Child module** — anything called via a `module` block, can nest arbitrarily deep.

**By source** — see the table in section 5 (local, Registry, Git, GitHub, Bitbucket, object storage).

**By design purpose** (from HashiCorp's module composition guidance):
- **Reusable/generic modules** — built to be called many times in many contexts, broad inputs (e.g. public registry modules like `terraform-aws-modules/vpc/aws`).
- **Composed/wrapper modules** — combine several reusable modules into one higher-level, org-specific pattern (e.g. an internal "our-standard-web-app" module wiring together a VPC + ALB + ASG module your way).
- **Facade/thin-wrapper modules** — wrap a *single* resource with your org's required defaults/tags/validation, exposing fewer inputs than the raw resource.

**By Terraform Registry trust tier** (publisher classification, shown as a badge):
- **Official** — authored/maintained directly by HashiCorp.
- **Partner** — published by a HashiCorp Technology Partner, verified by HashiCorp's partner program.
- **Community** — published by anyone, no vetting — check download counts/last-updated/issues before trusting one.

---

## 13. Quick glossary (cheat-sheet)

| Term | Plain-English meaning |
|---|---|
| **Module** | A reusable folder of Terraform code — a "recipe" for infrastructure. |
| **Root module** | The main folder you run Terraform from. Always exists automatically. |
| **Child module** | A module called by another module, using a `module` block. |
| **`source`** | Where the module's code lives (required for every module call). |
| **`version`** | Which version of a Registry module to use. |
| **Input variable** | A setting you pass *into* a module (like an ingredient amount). |
| **Output** | Information a module hands *back* to whoever called it. |
| **Module scoping** | The hard wall around a module's internals — only inputs/outputs (and provider config) cross it. |
| **`count` / `for_each`** | Create multiple copies of a module at once. |
| **Terraform Registry** | A public library of ready-made modules you can plug in. |

---

## 14. TL;DR — the one paragraph version

A Terraform **module** is just a reusable, packaged chunk of infrastructure code — and it behaves exactly like a function: well-defined inputs (input variables), well-defined outputs (output values), and everything else inside it (resources, data sources, locals) is completely hidden from whoever calls it, and vice versa. This hard boundary is called **module scoping** — the only things that cross it are input variables (parent → child), output values (child → parent), and provider configuration (which flows down automatically). Every project has a **root module** by default; you call **child modules** with a `module` block, pointing `source` at where the code lives, optionally pinning a `version`, and feeding it whatever inputs it defines. A tidy module folder has at minimum a `README.md`, `main.tf`, `variables.tf`, and `outputs.tf`.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: Modules overview, Module syntax, Module sources, Module inputs/outputs, Standard module structure, and related core-concepts pages (providers, resources, variables, outputs).*
