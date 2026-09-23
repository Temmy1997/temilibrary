# Terraform Dynamic Blocks 

---

## 1. The one-sentence version

A **dynamic block** repeats a small nested block *inside* a single resource, the same way `count`/`for_each` repeat a whole resource — a photocopier for just the inner section of a form, not the whole form.

---

## 2. The problem it solves

`count` and `for_each` are great for making N whole resources (N subnets, N users). But some resource types have a **nested block** inside them — a mini repeatable section — and sometimes you need a variable number of those, without duplicating the whole resource.

Think of a resource block like an order form. Most fields are one-time fills (name, size, region). But some forms have a repeatable line-item section — "list each accessory you want" — could be 1, could be 5. You don't want to hand-type that section every time the number changes. A `dynamic` block is the photocopier for that one repeatable section.

---

## 3. The setup — a resource with a repeatable nested section

Picture an EC2 instance that needs a variable number of extra hard drives attached. Each drive is its own nested block:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t3.micro"

  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 10
  }
  ebs_block_device {
    device_name = "/dev/sdi"
    volume_size = 20
  }
}
```

If the number of drives changes per environment, you're stuck manually adding/removing these blocks by hand. That's the exact problem `dynamic` solves.

---

## 4. Step 1 — the data to loop over

You need a list or map describing what should be repeated:

```hcl
locals {
  block_devices = {
    sdh = 10
    sdi = 20
  }
}
```

Read this as: "device `sdh` needs 10 GB, device `sdi` needs 20 GB."

---

## 5. Step 2 — the `dynamic` block itself

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t3.micro"

  dynamic "ebs_block_device" {
    for_each = local.block_devices
    iterator = ebs

    content {
      device_name = ebs.key
      volume_size = ebs.value
    }
  }
}
```

Breaking down each piece:

- **`dynamic "ebs_block_device"`** — "I want to generate multiple copies of the `ebs_block_device` nested block."
- **`for_each = local.block_devices`** — loop over this map, once per entry. (Can be a map or a list — no need for a set here.)
- **`iterator = ebs`** — while looping, refer to the current entry as `ebs` instead of the default name (which would be `ebs_block_device` — long and a little awkward, so people rename it).
- **`content { }`** — what each generated block actually contains, using `ebs.key` and `ebs.value` to pull the current entry's values.

Terraform loops through `block_devices` and generates one `ebs_block_device { }` per entry — exactly as if you'd hand-typed them.

---

## 6. The result — identical to hand-writing it

```hcl
ebs_block_device {
  device_name = "sdh"
  volume_size = 10
}
ebs_block_device {
  device_name = "sdi"
  volume_size = 20
}
```

Add a third entry to the `block_devices` map, and a third block appears automatically — no editing the resource itself.

---

## 7. The catch — use it sparingly

HashiCorp's own advice: don't reach for `dynamic` by default. It makes code harder to read and more brittle to update later. Most of the time, there's a better option: use a **separate resource** instead of a nested block.

For the EBS example:

```hcl
resource "aws_ebs_volume" "extra" {
  size = 10
}

resource "aws_volume_attachment" "extra" {
  volume_id   = aws_ebs_volume.extra.id
  instance_id = aws_instance.web.id
  device_name = "/dev/sdh"
}
```

Why this is often better: the EBS volume now has its **own independent lifecycle**. If the EC2 instance gets destroyed and recreated, the volume can survive on its own instead of being tied to the instance's fate. With a nested `dynamic` block, the sub-item lives and dies with the parent resource.

**One rule to remember:** for a given resource type, you generally pick one pattern or the other — nested dynamic blocks or separate resources — not both at once. Separate resources are the preferred pattern; dynamic blocks are for when you need to keep the same lifecycle, or a separate resource isn't available for that thing.

---

## 8. Quick glossary

| Term | Plain-English meaning |
|---|---|
| **Dynamic block** | Repeats a nested block inside one resource, a variable number of times. |
| **`for_each` (inside `dynamic`)** | The map or list to loop over — one generated block per entry. |
| **`iterator`** | Renames the loop variable from the block's default name to something shorter. |
| **`content { }`** | Defines what each generated nested block contains. |
| **Separate resource (alternative)** | Splitting the nested thing into its own resource + attachment resource instead — usually preferred. |

---

## 9. TL;DR

`dynamic` repeats a nested block inside a single resource, driven by a map/list, using `for_each`, `iterator`, and a `content { }` block to define what each generated copy looks like. It's useful, but HashiCorp recommends using it sparingly — a separate resource (with its own independent lifecycle) is usually the better pattern when the resource type supports one. You generally can't mix both patterns on the same resource.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: Dynamic Blocks.*
