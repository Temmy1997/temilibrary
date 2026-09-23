# Terraform Automation & CI: Simple Notes

## The main idea

Normally **you** run Terraform yourself: you type `plan`, read the output, and type `yes`.
In automation, **a robot runs it for you**. The robot is a pipeline in GitHub.
Nobody is there to type answers or log in, so you have to set things up for it ahead of time.

---

## Part 1: Things to think about before automating

### 1. What NOT to put in Git (`.gitignore`)

| File | Why it stays out |
|---|---|
| `.terraform/` | Downloaded plugins. `terraform init` downloads them again anyway. |
| `terraform.tfstate` | Terraform's record of what it built. It can contain passwords. |
| `.tfvars` files that hold secrets | They contain passwords or keys. |

GitHub has a ready-made Terraform `.gitignore` you can use.

### 2. What you SHOULD put in Git: `.terraform.lock.hcl`

- This file records the **exact provider version** Terraform used (for example, AWS provider 5.40.0).
- If you commit it, your laptop and the robot use the same version, so you get the same results.
- If you don't commit it, versions can quietly change, and you have to manage that yourself.

### 3. Faster downloads: `TF_PLUGIN_CACHE_DIR`

- Terraform downloads provider plugins every time you run `init`.
- If the build server keeps its files between runs, set `TF_PLUGIN_CACHE_DIR` to a folder. Terraform then reuses plugins it already downloaded instead of downloading them again.

### 4. Logins (credentials)

The robot needs a login for two things:
1. **The state storage**, for example an S3 bucket
2. **The cloud account**, where it creates the resources

Ways to give it a login:
- **Machine identity**: the server itself has a cloud identity.
- **Dynamic credentials (OIDC)**: short-lived logins that expire on their own. This is the safest option.
- **Static keys**: an access key and secret key saved in GitHub. This is the simplest option and the one the course uses.

### 5. Settings that change Terraform's behavior (environment variables)

| Variable | What it does in plain words |
|---|---|
| `TF_IN_AUTOMATION=true` | Tells Terraform "no human is watching," so it prints less. |
| `TF_INPUT=false` | Never ask questions. If a value is missing, **fail right away** instead of waiting forever. |
| `TF_LOG` | How much detail to log: `ERROR` → `WARN` → `INFO` → `DEBUG` → `TRACE` (most detail). |
| `TF_LOG_PROVIDER` | Log level for providers only, kept separate from the rest. |
| `TF_LOG_PATH` | Write the logs to a file instead of the screen. |
| `TF_VAR_<name>` | Gives a value to a variable. `TF_VAR_region=us-east-1` sets `var.region`. |
| `TF_CLI_ARGS` | Flags added to every command automatically, for example `-no-color`. |

### 6. Decisions to make

- **Save the plan or make a new one?** You can save the plan during CI and apply that exact file later, or create a new plan at deploy time.
- **Human approval?** Should someone review the plan before it is applied, even in test environments?
- **Auto-deploy?** Should non-production environments update automatically?
- **Errors:** When something fails, should the pipeline stop or keep going?
- **Logs:** Some platforms save logs for you. On others, you have to set where the logs go and how detailed they are.

---

## Part 2: Setting up CI with GitHub Actions

### What GitHub Actions is

- An **automatic job** that runs when something happens in GitHub, like a pull request, a push, or a new release tag.
- It is defined in a **YAML file** inside `.github/workflows/`. One file = one workflow.
- A **job** is a group of steps that runs on a machine called a **runner** (for example, Ubuntu).
- A **step** either uses a ready-made action (`uses:`) or runs a command (`run:`).
- `with:` passes inputs to an action.

### Setup needed before the pipeline works

1. **Create the GitHub repo.** The course does this with one command:
   ```bash
   gh repo create taco-wagon-app --public --source=. --remote=origin --push
   ```
2. **Create an S3 bucket** to store the state.
3. **Add AWS credentials** to GitHub so the robot can reach the bucket and the account.
4. **Put the bucket name** in the backend file (`backend/dev.hcl`).

### What the pipeline does

It runs on every **pull request to `main`**:

```
         ┌─ fmt ──────┐
PR  ───► ├─ validate ─┤  (all 4 run at the same time)
         ├─ tflint ───┤
         └─ trivy ────┘
                │ all passed?
                ▼
              plan ──► save plan file ──► post summary on the PR
```

### The 4 checks

| Check | Question it answers | Command |
|---|---|---|
| **Format** | Is the code neatly formatted? | `terraform fmt -check`. It changes nothing and fails if the formatting is off. |
| **Validate** | Is the code written correctly? | `terraform init -backend=false` then `terraform validate`. It skips the backend, so no login is needed. |
| **TFLint** | Does it follow best practices? | `tflint --init` then `tflint --recursive` |
| **Trivy** | Are there security problems? | The Trivy action. It only fails on **CRITICAL** issues. |

### The plan job

It only runs if **all 4 checks pass**. That's what `needs:` does.

Steps:
1. Get the code and install Terraform.
2. Log in to AWS using the saved access key and secret key.
3. `terraform init -backend-config=backend/dev.hcl` connects to the S3 bucket.
4. `terraform plan -var-file=environments/dev.tfvars -out=tf.plan` creates the plan and saves it.
5. **Upload Artifact** saves `tf.plan` as `tf-plan-dev-<run id>` so it can be used later.
6. **tf-summarize** turns the plan into a short summary and posts it as a **comment on the pull request**.

The plan job needs extra **permission** to comment on the pull request.

### Other details from the workflow file

- `TF_LOG: INFO` gives more detailed output.
- `TF_INPUT: false` stops Terraform from ever asking questions.
- The Terraform version is stored as a **GitHub repo variable**, so you can change it in one place.

---

## One-sentence summary

**When you open a pull request, GitHub checks your Terraform code four ways at the same time. If it all passes, GitHub makes a plan, saves it, and posts a summary on the pull request so you can see what will change before anything is deployed.**
