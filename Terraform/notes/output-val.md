# Terraform Output Values (`output`) 



## 1. The one-sentence version

An **output value** is how a Terraform config hands information back out — to you on the CLI, to a script, or to another module that called this one.

If `variable` is a blank you fill in on the way *in*, `output` is the receipt Terraform prints on the way *out*.

---

## 2. How it fits with `variable` and `locals`

Putting all three side by side (see my other notes docs for the full detail on each):

| | `variable` | `locals` | `output` |
|---|---|---|---|
| Direction | **In** | Internal | **Out** |
| Who sets it | You (CLI, `.tfvars`, env var) | You, computed in the config | Terraform, after apply |
| Purpose | Feed data into the config | Reusable internal shorthand | Expose data from the config |

Flow: **input (`variable`) → maybe combined into a `local` → used by resources → useful bits exposed as `output`.**

---

## 3. Basic syntax

```hcl
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

- The label (`"instance_ip"`) is the name you'll refer to it by.
- `value` is required — it's the expression whose result gets exposed. Can be a resource attribute, a variable, a local, a whole map/list, basically any valid expression.

After `terraform apply`, Terraform prints:

```
Outputs:

instance_ip = "3.90.12.44"
```

---

## 4. Why bother? (the real reasons)

**1. See useful info without digging through state.** Instead of grepping `terraform.tfstate` for an IP address or ARN, you just get it printed after apply, or via `terraform output`.

**2. Pass data between modules.** This is the big one. If you call a child module, the *only* way to get values out of it and into the parent config is through that module's `output` blocks. No outputs = the module is a black box that gives you nothing back.

**3. Feed other tools/scripts.** CI/CD pipelines, other Terraform configs (via `terraform_remote_state`), or plain scripts can read outputs programmatically (`terraform output -json`).

---

## 5. The example that made it click for me — module outputs

Say I have a child module that creates a VPC:

```hcl
# modules/vpc/main.tf
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
}

output "vpc_id" {
  value = aws_vpc.this.id
}
```

In the root config, calling that module:

```hcl
module "network" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "app" {
  vpc_id     = module.network.vpc_id   # <-- reading the module's output
  cidr_block = "10.0.1.0/24"
}
```

Without that `output "vpc_id"` block inside the module, `module.network.vpc_id` wouldn't exist — the parent has zero visibility into anything the module created unless the module explicitly outputs it.

---

## 6. Extra arguments you can add

```hcl
output "db_password" {
  value       = aws_db_instance.default.password
  description = "The master password for the database"
  sensitive   = true
  depends_on  = [aws_db_instance.default]
}
```

- **`description`** — documents what the output is, shows up when someone runs `terraform output` or inspects the module. Good habit, costs nothing.
- **`sensitive`** — hides the value from normal CLI output (shows `<sensitive>` instead). Doesn't encrypt it in the state file though — state still has the real value in plain text, so state file security still matters separately.
- **`depends_on`** — rarely needed since Terraform usually infers dependencies from the expression itself, but occasionally useful for a dependency that isn't visible in the expression.
- **`precondition`** (nested block) — lets you assert something must be true about the value before Terraform will accept it, and fail with a custom error message if not:

```hcl
output "instance_ip" {
  value = aws_instance.web.public_ip
  precondition {
    condition     = aws_instance.web.public_ip != ""
    error_message = "Instance did not get a public IP."
  }
}
```

---

## 7. Reading outputs after the fact

Once applied, you don't have to re-run apply to see outputs again:

```bash
terraform output                 # show all outputs
terraform output instance_ip     # show just one
terraform output -json           # machine-readable, for scripts/CI
```

---

## 8. Outputs and remote state

If another completely separate Terraform config needs a value from this one (not a module call, a totally different root config), outputs are also what gets read through a `terraform_remote_state` data source:

```hcl
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "my-tfstate-bucket"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "app" {
  subnet_id = data.terraform_remote_state.network.outputs.subnet_id
}
```

This only works because the network config defined `output "subnet_id" { ... }` — remote state reads pull *only* from outputs, never from arbitrary resource attributes inside that other state file.

---

## 9. Common gotchas / things to remember

- Outputs are **read-only results**, not something you can set from the CLI like a variable — they only ever come *from* the config, never go *into* it.
- An output's `value` is re-evaluated every apply — if the underlying resource attribute changes, the output changes too, no extra work needed.
- `sensitive = true` only hides it from console/CLI output — it is still stored in plaintext in the state file, so don't treat it as encryption.
- For a **module**, if you don't declare an output for something, the parent config literally cannot see it — this is the #1 reason people get confused when "the module clearly creates X but I can't reference it."
- Outputs can return complex types too — not just strings. A whole map, list, or object works fine as a `value`.

---

## 10. TL;DR

An `output` block is how a Terraform config exposes a value — to the terminal, to scripts via `terraform output`, to other configs via remote state, or most importantly, from a child module up to whatever called it. If a value isn't declared as an output, nothing outside that config/module can see it, no matter how "obviously available" it seems from inside.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: Output Values.*
