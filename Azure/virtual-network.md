Azure reserves 5 addresses in every subnet:

1. 10.0.1.0     Network address
2. 10.0.1.1     Default gateway
3. 10.0.1.2.    Azure DNS
4. 10.0.1.3     Azure DNS (second)
5. 10.0.1.255.  Broadcast

So you actually get 251 usable addresses for your VMs and other resources.# Azure VNet — Plain-Language Notes

## What it is

A Virtual Network (VNet) is your own private, isolated network inside Azure. 
- Think of it as your own office building in the cloud — you control who gets in, how the rooms (subnets) are laid out, and how they connect to other buildings (networks). 
- Resources like VMs, databases, and app services live inside a VNet and talk to each other privately unless you open things up.

VNets don't leave Azure — traffic within a VNet, or between peered VNets, stays on Microsoft's backbone instead of the public internet.

## Core building blocks

**Address space.** When you create a VNet, you give it an IP range using CIDR notation, like `10.0.0.0/16`. 
- This is the total pool of private IP addresses available to everything inside it. Pick a range that doesn't overlap with any network you might connect to later (on-prem, other VNets), because overlapping ranges can't be peered or connected via VPN.

**Subnets.** You carve the VNet's address space into smaller chunks called subnets, e.g. `10.0.1.0/24` for web servers, `10.0.2.0/24` for databases. 
- Subnets are how you segment and organize resources, and how you apply different security rules to different tiers of an app. 
- Azure reserves 5 IP addresses in every subnet for its own use, so your usable count is always 5 less than the math suggests.

### 
1. 10.0.1.0     Network address
2. 10.0.1.1     Default gateway
3. 10.0.1.2.    Azure DNS
4. 10.0.1.3     Azure DNS (second)
5. 10.0.1.255.  Broadcast

So you actually get 251 usable addresses for your VMs and other resources.

###

**Network Security Groups (NSGs).** These are basic firewalls — a list of allow/deny rules based on source/destination IP, port, and protocol. You attach an NSG to a subnet or a network interface to control inbound and outbound traffic. This is usually your first line of defense.

**Route tables (User-Defined Routes).** By default, Azure figures out how to route traffic automatically (system routes). If you want traffic to go somewhere non-default — like through a firewall appliance — you create a route table and attach it to a subnet.

**Network interfaces (NICs).** Every VM connects to a subnet through a NIC, which gets a private IP address (and optionally a public one).

## Connecting VNets to each other and the outside world

**VNet Peering.** Links two VNets so resources in each can talk to each other privately as if they were on the same network, with low latency and no bandwidth charge for traffic in the same region (cross-region peering does incur cost). Peering is not transitive — if A peers with B, and B peers with C, A cannot talk to C unless you peer them directly.

**VPN Gateway.** Connects your VNet to an on-premises network (or another VNet) over an encrypted tunnel across the public internet. 
- This is what you'd use to link a company office network to Azure.

**ExpressRoute.** A private, dedicated connection from your on-prem network to Azure that doesn't touch the public internet at all. Faster and more reliable than VPN, but costs more and takes longer to set up — used by enterprises with heavy or sensitive traffic needs.

**Service endpoints and Private Link.** These let you connect privately to Azure PaaS services (like Storage or SQL Database) without that traffic going over the public internet. Private Link is the more modern, more secure option because it gives the service its own private IP inside your VNet.

## Public vs. private access

Resources inside a VNet don't get internet access automatically in the way you might expect — outbound access to the internet is possible by default, but inbound access from the internet is not, unless you explicitly allow it (public IP, load balancer, NAT gateway, etc.). This "closed by default" posture is one of Azure's core security principles.

## DNS in a VNet

By default, Azure provides internal name resolution so resources in the same VNet can find each other by name. For more control (like resolving on-prem names, or using custom domains), you can point the VNet at your own custom DNS servers or use Azure Private DNS zones.

## Common things you'll actually configure

- **Hub-and-spoke topology**: a common enterprise pattern where one central "hub" VNet holds shared resources (firewall, VPN gateway) and multiple "spoke" VNets (per app or team) peer into it. Keeps networking centralized and easier to secure.
- **NSG rule priority**: rules are evaluated in order by priority number (lower number = evaluated first), and the first match wins.
- **Subnet delegation**: some Azure services (like App Service, Azure Container Instances) need a subnet "delegated" to them before they can be deployed into it.
- **NAT Gateway**: gives outbound internet traffic from a subnet a stable, predictable public IP — useful for allow-listing on external services.

## Why this matters for an Azure DevOps Engineer role

VNets are the backbone of almost every architecture decision you'll touch: where a VM or App Service can live, how a pipeline's build agents reach private resources, how Kubernetes (AKS) nodes get IPs, and how you lock down a database so it's not internet-facing. Expect VNet concepts to show up constantly in infrastructure-as-code (Terraform/Bicep/ARM templates) and in exam objectives for AZ-104 and AZ-400.

## Good next steps to actually learn it

1. Spin up a VNet with two subnets and an NSG in the Azure Portal (free tier is enough).
2. Deploy two VMs in different subnets and test connectivity with and without an NSG rule.
3. Try peering two VNets and pinging across them.
4. Read Microsoft Learn's "Azure Virtual Network" module — it's free and hands-on.
