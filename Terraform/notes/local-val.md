# LOCAL BLOCK IN TERRAFORM 
- LOcals block are used when you need to use the same value multiple times to avoid repeating yourself in a code. 
- You set it once in your local block and refrence it throughout ypur configuratipn. 


# Terraform Local Values (`locals`) — My Notes (Explained Like I'm a Dummy)

> Source: official Terraform docs at developer.hashicorp.com/terraform, simplified into plain English with my own examples.

---

## 1. The one-sentence version

A **local value** is a nickname you give to a value or expression so you don't have to type it out (or recompute it) over and over in your config.

That's it. Everything else below is just detail on top of that.

---

## 2. How it's different from a `variable`

This is the part that trips people up, so get this straight first:

| | `variable` | `locals` |
|---|---|---|
| Where the value comes from | **Outside** — you or someone else feeds it in (CLI flag, `.tfvars` file, environment variable) | **Inside** — you write it yourself, right there in the config |
| Can it be overridden at runtime? | Yes | No |
| What it's for | Input | Internal shorthand / computed value |

Mental model: `variable` = a blank on a form someone else fills in. `local` = a sticky note you wrote yourself so you don't have to redo the same math twice.

---

## 3. Basic syntax

```hcl
locals {
  env_prefix = "${var.environment}-${var.project_name}"
}
```

You then use it anywhere else in your config as `local.env_prefix` (singular "local", even though the block is called `locals`).

You can define as many values as you want inside one `locals` block, and you can have more than one `locals` block in a file or across files — Terraform just merges them all together. Most people group related ones together for readability.

---

## 4. Why bother? (the two real reasons)

**1. Don't repeat yourself.** If the same expression is needed in five places and you ever need to change it, you'd otherwise have to hunt down all five spots. With a local, you change it once.

**2. Make things readable.** `local.common_tags` tells a reader what it *means*. A giant inline map pasted five times tells them nothing extra and clutters the file.

---

## 5. The example that made it click for me — shared tags

```hcl
locals {
  common_tags = {
    Project     = "my-app"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0123456789"
  instance_type = "t3.micro"
  tags          = local.common_tags
}

resource "aws_s3_bucket" "data" {
  bucket = "my-app-data"
  tags   = local.common_tags
}
```

Both resources get the *exact same* set of tags, defined in exactly one place. Change the tags once, both resources update.

---

## 6. Locals can reference almost anything

Other locals, variables, resource attributes, data sources — Terraform figures out the dependency order for you automatically.

```hcl
locals {
  full_name = "${var.first_name} ${var.last_name}"
  greeting  = "Hello, ${local.full_name}!"
}
```

Notice `greeting` uses `local.full_name` — a local built from another local. Totally normal.

---

## 7. Where locals fit with the blocks I already know

Tying this back to variables and outputs (see my other notes doc):

- `variable` → info coming **in** from outside
- `output` → info going **out**, after apply
- `locals` → info I compute **internally**, from stuff I already have, so I don't repeat myself

Simple flow: **input → (maybe combined into a local) → used by resources → some of it exposed as output.**

---

## 8. Common gotchas / things to remember

- You **cannot** override a local from the command line or a `.tfvars` file — if you need that, it should be a `variable` instead.
- Locals are evaluated lazily/as-needed by Terraform's dependency graph, so order in the file doesn't matter — you can reference a local defined below another one.
- Don't overuse locals for things that are only used once — if a value is only needed in one spot, a local just adds an extra layer of indirection for no benefit. Save them for values that are reused or that meaningfully improve readability.

---

## 9. TL;DR

A `locals` block is a place to define your own named, reusable values inside a Terraform config — computed from variables, resources, data sources, or other locals — so you don't repeat expressions and so your code reads more clearly. Unlike `variable`, nobody feeds a local in from outside; you define it yourself.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: Local Values.*
