# Azure Kubernetes Service (AKS)

 # How we got here
- Traditional deployment: apps installed directly on servers, load balancer spreads traffic
- Problem: doesn't scale with frequent releases, many microservices, millions of users
- Docker: packages app + everything it needs into one image (`docker pull` + `docker run`, runs anywhere)
- Problem: Docker alone can't manage hundreds of containers across many servers
- Kubernetes: orchestrator — places containers, restarts failures, scales, handles updates automatically
- AKS: Azure's managed way of running Kubernetes

## 1. What is it?

Azure Kubernetes Service (AKS) is Microsoft's **managed** version of Kubernetes — the tool that automatically runs, restarts, and scales your containerized app across a group of servers.

"Managed" is the key word: Azure runs the hardest, most failure-prone part of Kubernetes (the **control plane** — basically Kubernetes' brain, deciding what runs where) for you, at no cost, and handles its health monitoring and maintenance. You only pay for the actual worker computers your app runs on.

## 2. The building blocks (in plain language)

- **Cluster** — the whole setup. Think of it as one complete AKS "installation."
- **Node** — a single virtual machine inside the cluster that actually runs your app's containers. You pick how big or small it is (more CPU/memory = more cost) based on what your app needs.
- **Node pool** — a group of identical nodes. AKS splits these into two types:
  - **System node pools** — run Kubernetes' own background housekeeping (like internal DNS).
  - **User node pools** — run your actual application.
  This split keeps your app's workload separate from the plumbing that keeps the cluster alive.

## 3. Two ways to run it

- **Standard mode** — the traditional, hands-on version. You configure networking, scaling, security, and upgrades yourself.
- **AKS Automatic** — the newer, simpler mode. Azure picks sensible defaults for you automatically: networking, security hardening, monitoring, auto-upgrades. You mostly just deploy your app rather than configure infrastructure. It even guarantees 99.9% of your app instances will be up and running within 5 minutes of being scheduled.

## 4. Scaling — growing and shrinking automatically

AKS scales in two directions at once:

- **Cluster autoscaler** — watches for containers that can't run because there isn't enough room, and automatically adds more nodes (machines) to make space. It removes them later when they're no longer needed, so you're not paying for idle capacity.
- **Horizontal Pod Autoscaler (HPA)** — adds or removes copies of your app itself based on load (like traffic spikes). Newer tooling (KEDA, Karpenter) extends this to scale based on custom signals like queue length, not just CPU usage.

## 5. Security, in plain terms

- Ties into **Microsoft Entra ID** by default for sign-in and permissions, so access to the cluster is controlled the same way as everything else in your organization.
- Network rules can restrict which containers are even allowed to talk to each other.
- Node software gets security patches applied automatically.
- **Azure Monitor** is set up out of the box, so you can see logs and metrics without configuring a separate monitoring system.

## 6. Pricing — three tiers

These prices are for the **control plane only** — the nodes/VMs are billed separately no matter which tier you pick.

| Tier | Cost | Best for | Notes |
|---|---|---|---|
| **Free** | $0 | Learning, testing, small non-critical projects | No uptime guarantee, not built for scale (under 10 nodes) |
| **Standard** | ~$0.10/cluster/hour | Real production workloads | 99.95% uptime guarantee, scales up to 5,000 nodes |
| **Premium** | ~$0.60/cluster/hour | Workloads needing extra migration time | Adds long-term support (LTS) for older Kubernetes versions |

## 7. Why it matters, put simply

Without AKS, you'd need to build and babysit Kubernetes' brain yourself — a genuinely hard, ongoing job. AKS hands you that brain for free, pre-wired into Azure's identity, monitoring, and security systems, and lets you decide how hands-on you want to be (Standard) versus how much you want Azure to just handle for you (Automatic).

## Analogy

If your app is a fleet of delivery trucks: containers are the trucks, Kubernetes is the dispatch system deciding routes and replacing broken-down trucks, and AKS is Azure being the dispatch company you rent instead of building your own dispatch center from scratch.

## Sources

- [What is Azure Kubernetes Service (AKS)? — Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/what-is-aks)
- [Azure Kubernetes Service (AKS) Core Concepts — Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/core-aks-concepts)
- [Create Node Pools in AKS — Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/create-node-pools)
- [Introduction to AKS Automatic — Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/intro-aks-automatic)
- [AKS Free, Standard, and Premium Pricing Tiers — Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/free-standard-pricing-tiers)
- [Scaling options for applications in AKS — Microsoft Learn](https://learn.microsoft.com/en-gb/azure/aks/concepts-scale)
- [Cluster autoscaling in AKS overview — Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/cluster-autoscaler-overview)
- [AKS pricing — Microsoft Azure](https://azure.microsoft.com/en-us/pricing/details/kubernetes-service/)
