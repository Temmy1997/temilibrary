# Terraform Variables — A Beginner's Guide

## What a variable is

A variable is a placeholder for a value you don't want to hard-code directly into your `.tf` files — things like a region name, an instance size, a resource group name, or a password. Instead of writing the same value in five places, you declare it once as a variable and reference it everywhere.

### FOR EXAMPLE ###
```hcl
variable "location" {
  type    = string
  default = "eastus"
}

resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = var.location
}
```

`var.location` is how you read a variable's value anywhere in your config. Think of `variable` blocks as defining the "inputs" your configuration accepts — the same idea as parameters in a function.

## Anatomy of a variable block

```hcl
variable "instance_count" {
  type        = number
  default     = 2
  description = "Number of VM instances to create"
  sensitive   = false
  nullable    = false

  validation {
    condition     = var.instance_count > 0
    error_message = "instance_count must be greater than 0."
  }
}
```

- **type** — restricts what kind of value is allowed (string, number,  list, etc. — covered below). If someone passes the wrong type, Terraform errors out before doing anything.
- **default** — the value used if nobody supplies one. If you omit `default`, the variable becomes required — Terraform will stop and prompt for it (or error, in automation) if it's not set some other way.
- **description** — plain-English explanation, shown in `terraform plan` output and docs. Doesn't affect behavior, purely for humans.
- **sensitive** — when `true`, Terraform hides the value from CLI output and logs (still stored in plain text in the state file though — sensitive doesn't mean encrypted).
- **nullable** — whether `null` is an acceptable value. Defaults to `true`. Set to `false` if you want to guarantee it always has a real value.
- **validation** — a custom rule beyond just type-checking (explained further down).

## DATA TYPE IN TERRAFORM 
The `type` argument controls what shape of data a variable will accept. Terraform will try to convert what you give it into that shape, and reject it if it can't.

### 1. Primitive Data types (the simple ones)

- **string** — text, e.g. `"eastus"`.
- **number** — any number, whole or decimal, e.g. `2` or `6.5`.
- **bool** — `true` or `false`.

Terraform will quietly convert between these when it makes sense — `15` becomes `"15"` if a string is expected, `"true"` becomes `true` if a bool is expected. It won't convert something like `"hello"` into a number, though — that fails.

### 2.  Collection types (multiple values of the *same* type)

- **list(TYPE)** — an ordered sequence, indexed from 0. Example: `list(string)` → `["a", "b", "c"]`.
- **set(TYPE)** — like a list, but unordered and with no duplicates.
- **map(TYPE)** — key/value pairs, all values sharing one type. Example: `map(string)` → `{ "env" = "prod", "team" = "infra" }`.

All elements inside a collection must be the same type — you can't put a string and a number in the same `list(string)`.

### 3. Structural types (multiple values, *different* types allowed)

- **object({...})** — a fixed set of named attributes, each with its own type. Example:

```hcl
variable "server" {
  type = object({
    name = string
    cpu  = number
    tags = list(string)
  })
}
```

- **tuple([...])** — like a list, but each position can be a different type, and the length is fixed. Example: `tuple([string, number, bool])` matches `["web", 3, true]` exactly — no more, no fewer elements.

### 4. `any` — the escape hatch

`any` means "figure out the type from what's actually given." It's tempting to use it to avoid writing a real type, but the official guidance is: **don't**. Only reach for `any` when you're passing the value straight through to something else (like `jsonencode()`) without ever inspecting its contents inside your config. If your code reads or manipulates the value at all, write the real type.

### 5. 'null'

It has no value  
### Optional attributes inside objects

By default, every attribute in an `object({...})` type is required. You can mark individual attributes optional, with or without a default:

```hcl
variable "bucket" {
  type = object({
    name    = string                # required
    enabled = optional(bool, true)  # optional, defaults to true if omitted
    tags    = optional(list(string))# optional, defaults to null if omitted
  })
}
```

This is handy for reusable modules — callers only have to specify what they actually care about; everything else falls back sensibly.

## Validation blocks — rules beyond type

Type constraints only check the *shape* of a value. If you need to enforce something more specific — a number within a range, a string matching a pattern — use a `validation` block:

```hcl
variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}
```

`condition` must evaluate to `true` for the value to be accepted; if it's `false`, Terraform stops and shows `error_message`. You can attach multiple `validation` blocks to one variable — each is checked independently.

Order of checks: Terraform validates the type constraint first, then runs your `validation` blocks. If the type doesn't match at all, your validation logic never even runs.

## Ways to actually set a variable's input value

There are five ways to feed a value into a variable, and Terraform needs a rule for what happens when more than one applies at once.

1. **Default value** in the `variable` block itself (lowest priority — only used if nothing else provides a value).
2. **Environment variables** — set as `TF_VAR_<name>`. Example: `export TF_VAR_location=westus`.
3. **`terraform.tfvars` or `terraform.tfvars.json`** — a file in your working directory that Terraform loads automatically, no flags needed.
4. **`*.auto.tfvars` or `*.auto.tfvars.json` files** — any file matching this naming pattern in the working directory is also loaded automatically, in alphabetical order by filename.
5. **`-var` and `-var-file` command-line flags** (highest priority) — e.g. `terraform apply -var="location=centralus"`. If you pass more than one, the last one on the command line wins.

## Precedence — what wins when several are set at once

From **highest priority (wins) to lowest**:

1. `-var` and `-var-file` flags on the command line
2. `*.auto.tfvars` / `*.auto.tfvars.json` files (alphabetical order)
3. `terraform.tfvars.json`
4. `terraform.tfvars`
5. `TF_VAR_*` environment variables
6. `default` in the variable block

A common misconception worth flagging: environment variables (`TF_VAR_*`) are actually *lower* priority than tfvars files, not higher. If you set `TF_VAR_location=westus` but also have `location = "eastus"` in `terraform.tfvars`, the tfvars file wins.

### Example of precedence in action

```hcl
variable "location" {
  type    = string
  default = "eastus"  # priority 6
}
```

```bash
export TF_VAR_location=westus        # priority 5
```

`terraform.tfvars`:
```hcl
location = "centralus"               # priority 4
```

```bash
terraform apply -var="location=northeurope"   # priority 1 — this one wins
```

Result: `var.location` resolves to `"northeurope"`, because the `-var` flag beats everything else.


# Variables 
* variables are used to parameterize your configurations, making them more flexible and reusable. 

## Varaibles Block 

## variables.tf
variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

## Vaariables Types 
In Terraform, variables have types associated with them, defining the kind of data that a variable can hold. Here are some common variable types in Terraform:

1. String
variable "name" {
  type    = string
  default = "John"
}

2. Number 

variable "age" {
  type    = number
  default = 25
}

3. List 

variable "colors" {
  type    = list(string)
  default = ["red", "green", "blue"]
}

(Note: You can have duplicate values)

4. Boolean 

variable "is_enabled" {
  type    = bool
  default = true
}

5. Map 

variable "settings" {
  type    = map(string)
  default = { key1 = "value1", key2 = "value2" }
}


6. Set 

variable "unique_numbers" {
  type    = set(number)
  default = [1, 2, 3]
}

(Set cannot have duplicate values)

7. Object 

variable "user" {
  type = object({
    name  = string
    age   = number
    email = string
  })

* EXAMPLE:
variable "bella" {
  type = object({
    name  = "Alice"
    age   = 30
    email = "alice@example.com"
  })
}

8. Tuples 
*Similar to list 

variable kitty {
  type    = tuple(string, number, bool)
  default = ["cat", "7", "true"]
}

## OUTPUTS VALUES
- Used to extract information from terafomrm deployment 
- printed to the terminal after running terraform apply 
- Used to pass information from a child module to parent module. 

resource "aws_instance" "web" {
  ami           = "ami-0123456789"
  instance_type = "t3.micro"
}

output "instance_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the web server"
}


 