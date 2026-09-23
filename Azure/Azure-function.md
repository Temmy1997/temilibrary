# Azure Functions — Notes

## What It Is

Azure Functions is Azure's **serverless compute service**. You write a small piece of code (a "function") that runs in response to an event. 
- Azure handles the server, scaling, and infrastructure — you never provision or manage a VM.

"Serverless" doesn't mean no server exists — it means you never have to think about it. Azure creates compute on demand, runs your code, then tears it down (or freezes it) when done.

---

## How It Actually Works

1. An event happens (a **trigger** fires).
2. Azure spins up a lightweight instance/container to run your code.
3. Your code executes and finishes.
4. The instance is either reused (if another trigger comes in soon — fast, "warm") or torn down (if idle — next run needs a fresh instance, causing a **cold start** delay).
5. If many triggers fire at once, Azure automatically creates multiple instances in parallel to handle load, then scales back down.

You write the "what to do." Azure manages the "where does this run."

---

## Triggers and Bindings

**Trigger** — the event that causes your function to run (there's exactly one per function).

Common triggers:
- **HTTP** — someone calls a URL/API endpoint
- **Timer** — runs code on a schedule (e.g., every day at 9am, cron-style)
- **Blob Storage** — a file is added/changed in storage
- **Queue Storage - ecoupling two parts of a system — one part adds messages to a queue, another part (often an Azure Function with a Queue trigger) picks them up and processes them, one at a time, independently.
- **Cosmos DB** — a document changes
- **Event Grid / Event Hub** — an event/stream arrives
- **SignalR, IoT Hub**, etc.

**Bindings** — declarative connections to input/output data sources, so you don't have to write SDK boilerplate to read/write data (e.g., automatically write output to a queue or database without manually opening a connection).

---

## Hosting Plans

| Plan | Behavior | Cold Start | Cost Model |
|---|---|---|---|
| **Consumption** | True serverless, scales to zero | Yes | Pay only per execution/resource use |
| **Premium** | Pre-warmed instances, VNet integration, longer run times | No (or minimal) | Pay for pre-warmed capacity + usage |
| **Dedicated (App Service Plan)** | Runs on VMs you already pay for | No | Fixed cost, no scale-to-zero |
| **Flex Consumption / Container Apps** | Newer hybrid options — serverless scaling with more control (e.g., VNet, custom containers) | Configurable | Usage-based, more flexible |

---

## Languages Supported

C#, JavaScript/TypeScript, Python, Java, PowerShell — natively via the Functions runtime. Other languages possible via custom handlers.

---

## Common Use Cases

- Simple APIs/microservices (HTTP trigger)
- Scheduled/cron jobs (timer trigger)
- Event-driven processing (file uploaded → resize image, message arrives → process it)
- Gluing services together (automation, webhooks)
- Lightweight backend logic without a full App Service


## Durable Functions

An extension for building **stateful workflows** out of otherwise stateless functions — e.g., chaining function calls, fan-out/fan-in patterns, or long-running orchestrations that wait for human approval. Useful when a single event needs multi-step, ordered processing.

---

## Local Development

- **Azure Functions Core Tools** — CLI for running/debugging functions locally, mimics the Azure runtime.
- **VS Code Azure Functions extension** — scaffolds projects, lets you run/debug locally, and deploy directly from the editor.
- Typical project has a `function.json` (bindings/config) per function (or attribute-based config in the "isolated worker" model for C#), plus `host.json` for app-wide settings and `local.settings.json` for local environment variables (not deployed).

---

## Deployment (DevOps-relevant)

- **Zip deploy** — package and push code directly.
- **Container deploy** — package function app as a Docker image (useful for custom dependencies, Premium/Container Apps).
- **Infrastructure as Code** — define the Function App resource via **Bicep**, **ARM templates**, or **Terraform**.
- **CI/CD** — commonly deployed via **Azure DevOps Pipelines** or **GitHub Actions**, triggering build + deploy on code push.
- **Deployment slots** (on Premium/Dedicated) — allow staging deployments and swapping into production with near-zero downtime.

---

## Monitoring & Security

- **Application Insights** — built-in integration for logging, tracing, and performance monitoring of function executions.
- **Authorization levels** (HTTP trigger): `anonymous`, `function` (key required), `admin` (master key required).
- **Managed Identity** — lets a function authenticate to other Azure resources (Key Vault, Storage, SQL) without storing credentials in code.
- **App Settings / Key Vault references** — used to store secrets/config securely instead of hardcoding.

---

## One-Line Summary

Azure Functions lets you run small, event-triggered pieces of code without owning, configuring, or maintaining a server — Azure creates just enough compute, exactly when needed, and removes it when the job's done.
