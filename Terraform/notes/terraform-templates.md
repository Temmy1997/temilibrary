# Terraform Templates — 



## 1. The one-sentence version

A **template** is a fill-in-the-blank file — you write it once with blanks (`${ }`), and Terraform's `templatefile()` function fills thoseh blanks in with real values and hands you back the finished text.

Think of a form letter: "Dear _____, your order of _____ items ships on _____." The blank letter is useless on its own — someone has to fill it in before it becomes a real letter. That's exactly what a Terraform template is.

---

## 2. Step 1 — write the blank file (the template)

Just a plain text file (shell script, config file, whatever you need) with blanks marked using `${ }`:

```bash
#!/bin/bash
echo "Hello, my name is ${server_name}"
```

Save it as its own file, e.g. `greeting.sh.tpl`. The `.tpl` extension is just convention — it's still plain text, and `${server_name}` isn't a real value yet, it's a placeholder waiting to be filled.

---

## 3. Step 2 — fill in the blanks (`templatefile()`)

In your `.tf` file, call `templatefile()` with two things: the path to the file, and a map of values to plug into the blanks.

```hcl
templatefile("greeting.sh.tpl", {
  server_name = "web-01"
})
```

Read this as: *"Open `greeting.sh.tpl`. Wherever you see `${server_name}`, put in `web-01`."*

**The names must match exactly** — the blank `${server_name}` in the file needs a key called `server_name` in the `{ }` map. Miss one and Terraform errors out because it doesn't know what to put there.

---

## 4. Step 3 — what you get back

A finished string, blanks filled in:

```bash
#!/bin/bash
echo "Hello, my name is web-01"
```

That's it — the whole mechanic is: `${name}` in the file ↔ `name = "value"` in the function call.

---

## 5. Multiple blanks — same pattern, just more of it

```bash
# greeting.sh.tpl
echo "Hello, ${server_name}, welcome to ${environment}"
```

```hcl
templatefile("greeting.sh.tpl", {
  server_name = "web-01"
  environment = "production"
})
```

Output:
```
Hello, web-01, welcome to production
```

---

## 6. A real example — EC2 user-data script

```bash
# init.sh.tpl
#!/bin/bash
echo "Setting up server: ${server_name}"
echo "Environment: ${environment}"

%{ if enable_monitoring }
echo "Installing monitoring agent..."
%{ endif }

%{ for pkg in packages }
apt-get install -y ${pkg}
%{ endfor }
```

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t3.micro"

  user_data = templatefile("${path.module}/init.sh.tpl", {
    server_name       = "web-01"
    environment       = var.environment
    enable_monitoring = true
    packages          = ["nginx", "htop", "curl"]
  })
}
```

Rendered output (given those values):

```bash
#!/bin/bash
echo "Setting up server: web-01"
echo "Environment: dev"

echo "Installing monitoring agent..."

apt-get install -y nginx
apt-get install -y htop
apt-get install -y curl
```

---

## 7. The two directives beyond a plain blank

Regular `${ }` just drops in a value. Two more directives let the template make decisions:

- **`%{ if condition } ... %{ endif }`** — include that chunk of text only if `condition` is true. (Above: the monitoring line only appears because `enable_monitoring = true`.)
- **`%{ for item in list } ... %{ endfor }`** — repeat that chunk once per item in the list. (Above: one `apt-get install` line per package in `packages`.)

Both are just template syntax for the same `if`/`for` logic you already use elsewhere in Terraform expressions — they just live inside the template file instead of a `.tf` file.

---

## 8. Why bother with a separate file instead of one long string?

For a one-liner, you wouldn't. Templates earn their keep once the content is long (a real startup script, a full config file) — cramming 20+ lines into one escaped string inside a `.tf` file is unreadable. Keeping it as its own `.sh.tpl` / `.conf.tpl` / `.yaml.tpl` file means your editor still color-codes it properly, since it still looks like the real file type.

---

## 9. Where templates show up in practice

- `user_data` scripts for EC2 instances
- `cloud-init` configs
- Kubernetes manifests generated per environment
- Config files (nginx.conf, app config) that are mostly static with a few dynamic values

---

## 10. A note on the old way

You may see `data "template_file" "..." { ... }` in older code or tutorials — that was a separate **data source** used before `templatefile()` existed. It's deprecated now. `templatefile()` (the function) does the same job with less boilerplate — no separate data block, just call it inline wherever you need the rendered string.

---

## 11. How this connects to functions and expressions

- `templatefile()` is just one function in Terraform's built-in function library (same family as `file()`, `jsonencode()`, etc. — see [[terraform-expressions-and-functions-notes]]).
- The `${ }` syntax inside a template file is the exact same string-interpolation syntax used in regular `.tf` files.
- So a "template" isn't a separate language — it's ordinary Terraform expression syntax, just living inside an external file instead of inline.

---

## 12. Quick glossary

| Term | Plain-English meaning |
|---|---|
| **Template file** | A plain text file with `${ }` blanks, meant to be filled in. |
| **`templatefile(path, vars)`** | The function that reads the file, fills in the blanks, and returns the finished text. |
| **`${name}`** | A blank in the template — filled by the matching key in the `vars` map. |
| **`%{ if }` / `%{ endif }`** | Conditionally include a chunk of the template. |
| **`%{ for }` / `%{ endfor }`** | Repeat a chunk of the template once per item in a list. |
| **`template_file` data source** | The old, deprecated way of doing this — replaced by `templatefile()`. |

---

## 13. TL;DR

A template is a text file with `${ }` blanks. `templatefile("file.tpl", { key = value, ... })` reads that file, swaps every `${key}` for its matching value, evaluates any `%{ if }` / `%{ for }` directives, and returns the finished string — used for things like EC2 user-data scripts or generated config files where most of the content is static but a few values need to change per environment.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: templatefile function, String Templates.*
