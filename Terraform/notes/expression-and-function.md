# Terraform Expressions & Functions 
## Part 1: Expressions

An **expression** is anything Terraform evaluates to produce a value — it's whatever sits on the right-hand side of an `=` that isn't just sitting there as a bare literal. If you've written a `variable`, `local`, `output`, or `resource` argument, you've already been writing expressions.

## 1. Literals — the simplest expression

Just a plain, hardcoded value:

```hcl
instance_type = "t3.micro"
```

### 2. References — pointing at something else

```hcl
instance_type = var.instance_size          # a variable
ami           = data.aws_ami.ubuntu.id     # a data source
tags          = local.common_tags          # a local
ip            = aws_instance.web.public_ip # a resource attribute
```

### 3. String interpolation — plugging a value into a string

Use `${ }` inside a string to drop a value into the middle of it:

```hcl
name = "web-${var.environment}-${count.index}"
```

### 4.  Operators — math, comparison, and conditionals (if statement)

```hcl
instance_count = var.is_production ? 3 : 1     # conditional (ternary): condition ? true_val : false_val
total          = var.base_count + var.extra_count
is_valid       = var.env == "prod"
```



### 7. For expressions — a loop that builds a list or map

```hcl
subnet_ids = [for s in aws_subnet.all : s.id]
```


## Part 2: Functions

A **function** is a built-in helper you call inside an expression to transform or compute a value — like an Excel formula, but for Terraform config. You can't write your own; Terraform ships a fixed library of them.

### 1. Syntax

Always the same shape: `function_name(argument1, argument2, ...)`

```hcl
upper("hello")   # → "HELLO"
```

### 2. String functions — manipulate text

```hcl
upper("dev")                          # "DEV"
lower("DEV")                          # "dev"
trimspace("  hi  ")                   # "hi"
replace("hello-world", "-", "_")      # "hello_world"
format("web-%s-%d", var.env, 3)       # "web-prod-3"
```

### 3. Collection functions — work with lists and maps

```hcl
length(var.subnet_ids)                # count of items
join(",", ["a", "b", "c"])            # "a,b,c"
split(",", "a,b,c")                   # ["a", "b", "c"]
contains(["a", "b"], "a")             # true
lookup(var.tags, "Name  ", "default")   # get a map value, with a fallback
merge(local.tags1, local.tags2)       # combine two maps
```

### 5. Numeric functions

```hcl
max(5, 10, 3)      # 10
min(5, 10, 3)      # 3
ceil(4.1)          # 5
```

### 6. Type conversion functions — force a value into a specific type

```hcl
tostring(5)          # "5"
tonumber("5")         # 5
tolist(["a","b"])
```

### 7. Encoding functions — common in cloud configs (e.g. AWS user-data scripts)

```hcl
base64encode("hello")
jsonencode({ name = "web" })
```

### 8. Filesystem functions — read a local file's content right into your config

```hcl
file("${path.module}/init.sh")
```

### 9. Date/time functions

```hcl
timestamp()   # current UTC timestamp
```

### 10.  Templates — `templatefile()`, the one filesystem function that deserves its own callout

A template is a text file with `${ }` blanks in it. `templatefile()` reads that file, fills the blanks from a map you pass in, and returns the finished string.

```hcl
templatefile("init.sh.tpl", {
  server_name = "web-01"
  environment = var.environment
})
```

- Blank in the file (`${server_name}`) ↔ key in the map (`server_name = "..."`) — names must match exactly.
- Inside the template, `%{ if cond } ... %{ endif }` and `%{ for x in list } ... %{ endfor }` let you conditionally include or repeat chunks of text.
- Used for things like EC2 `user_data`, cloud-init configs, or any generated config file.
- Replaces the old, deprecated `data "template_file"` data source — `templatefile()` is the current way.

Full walkthrough with a real user-data example: see [[terraform-templates-notes]].


### 11. Things worth remembering

- Functions are **built-in only** — no custom functions in HCL. If you need custom logic, compose built-in functions, break it into `local` steps, or reach for a `data "external"` source.
- You can **nest** functions, just like nested formulas: `upper(trimspace(var.name))`
- Use **`terraform console`** to drop into a REPL and try an expression/function live before committing it to a `.tf` file — fastest way to check what something actually returns.

### 11. TL;DR — functions
* terraform console - It is used for Testing functions before you commit to them in code.
Functions are Terraform's built-in toolbox for transforming values inside expressions — strings, numbers, collections, types, encoding, files, dates. No custom ones; compose the built-ins or use `terraform console` to experiment.

---
## Part 3: The `count` Meta-Argument

### 1. The one-sentence version

`count` is a **meta-argument** (an instruction to Terraform itself, not a value sent to AWS/Azure/etc.) that tells Terraform "make this many copies of this block." Think of it as a photocopier: you design the resource once, and `count` tells the copier how many copies to print.

### 2. Where it's allowed

`count` can go on a `resource`, `data`, or `module` block.

```hcl
resource "aws_subnet" "public" {
  count = 3
}
```

This one block produces **3 separate subnets**, not 1. The value doesn't have to be a hardcoded number — it can come from a variable, a local, or a conditional expression.

### 3. `count = 0` — the on/off switch

`count` accepts `0`, meaning "create nothing." That's the trick for making a whole resource conditional:

```hcl
resource "aws_instance" "bastion" {
  count = var.enable_bastion ? 1 : 0
}
```

Reads as: "if `enable_bastion` is true, make 1; otherwise make 0."

### 4. `count.index` — the number stamped on each copy

Inside a block using `count`, Terraform gives you `count.index` — which copy is currently being built. **Starts at 0**, so `count = 3` gives indexes `0`, `1`, `2`.

Use it to make each copy slightly different (a different CIDR, a different name):

```hcl
resource "aws_subnet" "public" {
  count             = 3
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = var.azs[count.index]

  tags = {
    Name = "public-subnet-${count.index + 1}"   # +1 so names read 1, 2, 3 instead of 0, 1, 2
  }
}
```

### 5. Referencing one specific copy later

Once a resource is built with `count`, it's a **list** of instances, not a single one. Point at a specific one with `[index]`:

```hcl
aws_subnet.public[0].arn   # first copy's ARN
aws_subnet.public[1].arn   # second copy's ARN
```

Same pattern for modules and data sources built with `count`.

### 6. The splat expression — grabbing ALL the copies at once

Swap the index number for a `*` to get every instance's value as a list, instead of just one:

```hcl
aws_subnet.public[*].arn
```

Returns a list of every subnet's ARN — handy for feeding all of them into something else, like a route table association.

### 7. Quick glossary

| Term | Plain-English meaning |
|---|---|
| **Meta-argument** | An instruction to Terraform about *how* to build config — not a value passed to the provider. |
| **`count = N`** | Make N copies of this resource/data/module block. |
| **`count = 0`** | Make none — used to make a whole resource conditional. |
| **`count.index`** | Which copy (starting at 0) is being built right now. |
| **`resource[1]`** | Reference one specific copy by index. |
| **`resource[*]`** | Splat — get a list of that attribute from *every* copy. |

### 8. TL;DR — count

`count` is DRY for infrastructure: write a resource once, tell it how many copies to make, and use `count.index` to give each copy something unique (a name, a CIDR block). Reference one copy with `[index]`, or all of them at once with the splat `[*]`. `for_each` is the other looping meta-argument — covered separately since it works off a map/set instead of a plain number.

## Part 5: The `for_each` Meta-Argument

**What it is:** Like `count`, but tracks each copy by a **name/key** instead of a position number — a guest list with name tags, not a photocopier with page numbers.

**Why it matters:** with `count`, removing a middle item shifts everyone after it down a position, and Terraform destroys/recreates them too. With `for_each`, each copy is tied to its own key, so removing one only removes that one.

```hcl
resource "aws_iam_user" "team" {
  for_each = toset(["alice", "bob", "carol"])
  name     = each.value
}
```

- `for_each` takes a **set** or a **map** — never a plain number.
- `each.key` / `each.value` = the current entry (same value for a set; key/value pair for a map).

**Map example** — when each entry needs its own extra data:

```hcl
locals {
  users = {
    alice = "admin"
    bob   = "readonly"
  }
}

resource "aws_iam_user" "team" {
  for_each = local.users
  name     = each.key            # "alice", "bob"
  tags     = { role = each.value } # "admin", "readonly"
} 
```

**Referencing one instance** — use the key, not an index:

```hcl
aws_iam_user.team["alice"].arn
```

| | `count` | `for_each` |
|---|---|---|
| Input | a number | a set or map |
| Tracks by | position (0, 1, 2) | key/name |
| Reference one | `resource[0]` | `resource["name"]` |
| Remove a middle item | can reshuffle/recreate others | only removes that one |


## How expressions and functions relate

An expression is the general concept ("something that evaluates to a value"). A function call is just *one kind* of expression — the kind where you're invoking a built-in helper instead of just referencing a variable or writing a literal. Every function call you write *is* an expression, but not every expression involves a function.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: Expressions, Built-in Functions.*
