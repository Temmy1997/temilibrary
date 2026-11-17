# Terraform `coalesce()` — My Notes (Explained Like I'm a Dummy)

> Source: official Terraform docs at developer.hashicorp.com/terraform (coalesce function), simplified into plain English with my own examples.

---

## 1. The one-sentence version

`coalesce()` looks through a list of values **from left to right** and gives you back the **first one that isn't `null` or an empty string `""`**.

It's a "fallback chain": *try this, if it's empty try that, if that's empty try the next one.*

---

## 2. Mental model

Think of ordering lunch with backup plans: "I want pizza. If they're out, I'll have a burger. If they're out of that too, just give me a salad." `coalesce()` walks down that list and hands you the first thing that's actually available.

---

## 3. Basic syntax

```hcl
coalesce(value1, value2, value3, ...)
```

You can pass as many values as you want. It returns the first "real" one.

---

## 4. Examples you can try in `terraform console`

```hcl
coalesce("a", "b")          # "a"      (first one is fine)
coalesce("", "b")           # "b"      (empty string is skipped)
coalesce(null, "b")         # "b"      (null is skipped)
coalesce(null, "", "c")     # "c"      (skips both)
coalesce(1, 2, 3)           # 1
coalesce(null, 5)           # 5
```

What counts as "empty" and gets skipped:

- `null`
- `""` (empty string)

What does **not** get skipped (this surprises people):

- `0`, `false` → real values, they get returned
- `[]` (empty list) and `{}` (empty map) → not skipped. Use `coalescelist()` for lists.

---

## 5. Real-world use — optional variable with a fallback

```hcl
variable "custom_name" {
  type    = string
  default = null     # user may or may not provide one
}

locals {
  server_name = coalesce(var.custom_name, "web-default")
}
```

- User passes `custom_name = "api-01"` → `local.server_name` is `"api-01"`
- User passes nothing (null) or `""` → `local.server_name` is `"web-default"`

---

## 6. Real-world use — chain of fallbacks

```hcl
locals {
  region = coalesce(
    var.region_override,      # 1st choice: explicit override
    var.default_region,       # 2nd choice: team default
    "us-east-1"               # last resort: hardcoded
  )
}
```

Tip: put a hardcoded value **last** so the chain can never come up empty.

---

## 7. What if EVERYTHING is null/empty?

Terraform throws an **error** (no usable argument). So always end with a safe literal, or you'll get a failed plan.

```hcl
coalesce(null, "")     # ERROR - nothing to return
```

---

## 8. Passing a list into `coalesce()` — the `...` trick

`coalesce()` wants separate arguments, not one list. If your values are in a list, "expand" it with `...`:

```hcl
coalesce(["", "hello", "world"]...)   # "hello"
```

---

## 9. Type rule

All the values should be the **same type** (or convertible to one). Mixing, say, a string and a number gets auto-converted when possible:

```hcl
coalesce("a", 2)   # "a"  (the 2 gets converted to the string type)
```

Keep types consistent to avoid confusing results.

---

## 10. Related functions (don't confuse them)

| Function | What it does |
|---|---|
| `coalesce(a, b, ...)` | First value that's not `null` / `""` |
| `coalescelist(list1, list2, ...)` | First list that's **not empty** (use for lists) |
| `try(expr, fallback)` | Fallback if an expression **errors** (e.g. missing map key) |
| `lookup(map, key, default)` | Get a map value, with a default if the key is missing |
| `condition ? a : b` | Ternary — more manual, more verbose version of a fallback |

**When to use which:**
- Value might be `null` or blank → `coalesce`
- Value is a list that might be empty → `coalescelist`
- Expression might blow up → `try`

---

## 11. Common gotchas

- Forgetting a final fallback → plan errors if everything is empty.
- Expecting `[]` or `{}` to be skipped → they're not; use `coalescelist()` for lists.
- Expecting `0` or `false` to be skipped → they're real values, so they're returned.
- Passing a list directly without `...` → it's treated as one single argument.

---

## 12. Cheat-sheet

| You write | You get |
|---|---|
| `coalesce("", "b")` | `"b"` |
| `coalesce(null, null, "c")` | `"c"` |
| `coalesce(var.x, "default")` | `var.x` if set, else `"default"` |
| `coalesce(["", "a"]...)` | `"a"` |
| `coalesce(null, "")` | ❌ error |

---

## 13. TL;DR

`coalesce(a, b, c, ...)` returns the first argument that isn't `null` or `""`. Use it to give optional variables a default or to build a priority chain of fallbacks. End with a hardcoded value so it never errors, use `...` to expand a list, and use `coalescelist()` when dealing with lists.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: coalesce function, coalescelist function.*
