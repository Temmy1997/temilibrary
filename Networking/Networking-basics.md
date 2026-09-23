# Azure Networking Concepts — Hub-Spoke, VNets, VPN & DNS

## 1. VNet (Virtual Network)

A VNet is your private, isolated network space inside Azure — your own slice of the cloud, similar to a network in a traditional datacenter.

- Has its own private IP address range (CIDR block), e.g. `10.0.0.0/16`.
- Resources inside it (VMs, databases, App Service with VNet integration) can talk to each other privately.
- Isolated from other VNets and the internet by default, until you explicitly connect it.

## 2. Subnet

A subnet is a subdivision of a VNet's address space, used to segment resources and apply different rules to each segment.

- Example: `10.0.1.0/24` for web tier, `10.0.2.0/24` for database tier, `10.0.3.0/24` for a firewall appliance.
- Each subnet can have its own Network Security Group (NSG) and route table.
- Some subnets are reserved/special-purpose:
  - `GatewaySubnet` — required for VPN or ExpressRoute gateways.
  - `AzureFirewallSubnet` — required for Azure Firewall.

## 3. Hub-and-Spoke Topology

An architectural pattern (not a specific resource) for organizing multiple VNets.

- **Hub VNet** — central VNet holding shared services:
  - VPN Gateway / ExpressRoute Gateway (connects to on-premises)
  - Firewall / NVA (centralized traffic inspection)
  - DNS servers
  - Shared tools (monitoring, bastion/jump box)
- **Spoke VNets** — workload-specific VNets (e.g. production app, dev/test, shared data services), isolated from each other by default.
- Benefit: centralized security and connectivity management instead of duplicating it per VNet.

## 4. VNet Peering

How the hub connects to each spoke (and how any two VNets connect in general).

- Links two VNets so traffic flows over Microsoft's private backbone, not the public internet.
- Low latency, no gateway required for the peered connection itself.
- **Not transitive by default** — Spoke A can't reach Spoke B automatically just because both peer to the hub.
- To allow spoke-to-spoke traffic (typically routed through the hub firewall for inspection), you configure **User-Defined Routes (UDRs)**.

## 5. VPN Gateway & Tunneling into Azure

### What the VPN Gateway does

Deployed in the hub VNet's `GatewaySubnet`, the VPN Gateway is the Azure-side endpoint for connecting an on-premises network into your Azure VNets privately.

### The tunnel itself

- The connection is a **Site-to-Site (S2S) VPN**, built using the **IPsec/IKE** protocol suite.
- One end of the tunnel is your on-premises VPN device (a physical or virtual firewall/router that supports IPsec).
- The other end is the Azure VPN Gateway in the hub.
- **IKE (Internet Key Exchange)** — Phase 1 negotiates a secure, authenticated channel between the two gateways (using a pre-shared key or certificates) and establishes the security association (SA).
- **IPsec** — Phase 2 uses that channel to negotiate encryption for the actual data tunnel, then encrypts and encapsulates every packet that crosses between on-prem and Azure.
- The tunnel runs **over the public internet**, but because it's encrypted end-to-end, traffic inside it is private — machines on both sides use their normal private IPs as if on one network.
- Once established, this is called a **Connection** resource in Azure, linking a **Local Network Gateway** (representing your on-prem side: its public IP and address ranges) to the **Virtual Network Gateway** (the Azure side).

### Tunnel to VNet — how traffic actually flows

1. Traffic leaves an on-prem machine destined for a private IP in the Azure VNet.
2. It hits the on-prem VPN device, which encrypts/encapsulates it into the IPsec tunnel and sends it over the internet to the Azure VPN Gateway's public IP.
3. The Azure VPN Gateway decrypts the packet and forwards it into the `GatewaySubnet`, then onward into the hub VNet.
4. From the hub, **route tables and VNet peering** carry the packet into the correct spoke VNet and subnet.
5. Return traffic follows the same path in reverse, back through the tunnel to on-prem.

### Gateway SKUs and throughput

- Gateway SKU (Basic, VpnGw1–5, etc.) determines tunnel throughput and the number of simultaneous tunnels/connections supported.
- Multiple tunnels can terminate on one VPN Gateway (e.g. connections to multiple branch offices, or active-active tunnels for redundancy).

### VPN vs. ExpressRoute

- **VPN Gateway (S2S)**: encrypted tunnel over the public internet — cheaper, quicker to set up, variable latency.
- **ExpressRoute**: a dedicated private circuit via a connectivity provider, not traversing the public internet — higher bandwidth, more consistent latency, no IPsec encryption by default (traffic is private by virtue of the dedicated circuit, though you can layer encryption on top).
- Both can terminate in the hub VNet and both can coexist (VPN as backup to ExpressRoute, for example).

## 6. DNS in Each VNet

- **Azure-provided DNS (168.63.129.16)** is the default — gives basic name resolution *within* a single VNet plus internet resolution, but does **not** span multiple VNets or resolve on-premises names.
- In a hub-and-spoke + hybrid (VPN/ExpressRoute) setup, you typically deploy **custom DNS servers** — often as VMs in the hub, or using **Azure DNS Private Resolver** — so that:
  - Resources across all spokes can resolve each other's names.
  - On-prem systems can resolve Azure resource names, and Azure can resolve on-prem names (often via conditional forwarding).
  - Every VNet's DNS settings point to these central DNS servers instead of the Azure default.

## 7. Putting It All Together

```
On-Premises Network
        │
        │  IPsec VPN Tunnel (IKE + IPsec, over public internet)
        │
   VPN Gateway (in GatewaySubnet)
        │
     Hub VNet ── Firewall/NVA ── DNS Servers
        │
   VNet Peering (non-transitive, routed via UDRs through hub firewall)
        │
   ┌────┴────┬────────────┐
Spoke VNet A  Spoke VNet B  Spoke VNet C
(e.g. Prod)   (e.g. Dev)    (e.g. Shared Data)
```

- On-prem connects to the hub via the VPN tunnel.
- The hub centralizes the gateway, firewall, and DNS.
- Spokes peer to the hub and route inter-spoke or outbound traffic through the hub's firewall.
- Every VNet uses the hub's DNS servers for unified, hybrid-aware name resolution.



## LAN (Local Area Network)


** IP is a unique number that is used to identify devices on a network. 
** Switch - It is a devuce that helps to talk to various device on the same network 
** Router - It is a device that helps to connect home devices to the internet, that means its coenct device on the same network to outiside device on a differnet network 


## Cloud VPN (Azure)

** VPN = a private, encrypted tunnel built over the public internet, so two networks can talk to each other safely as if they were directly wired together.

** VNet (Virtual Network) - your own private network inside Azure, like your office building but in the cloud. Your VMs/resources live inside it.

** VPN Gateway - the Azure resource that sits at the edge of the VNet and does the actual encrypt/decrypt. This is the "tunnel doorway".

** Gateway Subnet - a small dedicated subnet inside the VNet reserved only for the VPN Gateway (no VMs go here).

** Local Network Gateway - represents the OTHER end of the tunnel (your on-prem router's public IP + the address ranges behind it), so Azure knows what it's connecting to.

** IPsec/IKE - the encryption protocol standard that actually secures the tunnel.

Connection types:
** Site-to-Site (S2S) - connects your WHOLE on-prem network to your WHOLE Azure VNet, via a permanent tunnel between your on-prem VPN device and Azure's VPN Gateway.
** Point-to-Site (P2S) - connects a SINGLE device (like your laptop) straight into the Azure VNet, over the internet, using a VPN client. Good for remote workers.
** VNet-to-VNet - same as site-to-site but BOTH ends are Azure VNets (each with its own VPN Gateway) instead of one end being a physical office.

VPN Gateway vs ExpressRoute:
** VPN Gateway = tunnel over the public internet. Cheaper, faster to set up.
** ExpressRoute = private dedicated line straight into Microsoft's network, never touches the public internet. Faster/more reliable, costs more.
** VPN Gateway can act as a backup failover path for ExpressRoute.

Gateway SKUs = the "size" you pick for the gateway (throughput, max tunnels, BGP support, zone-redundancy). Bigger SKU = more bandwidth/cost, e.g. VpnGw1AZ (~650 Mbps) up to VpnGw5AZ (~10 Gbps). 