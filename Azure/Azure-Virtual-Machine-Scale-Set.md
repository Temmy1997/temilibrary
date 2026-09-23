## Azure Virtual Machine Scale Set (VMSS)

> "A Virtual Machine Scale Set lets you deploy and manage a group of identical, load-balanced VMs from a single template. 
> Instead of manually creating each VM, you define one configuration — image, size, extensions — and Azure replicates it across as many instances as needed, automatically, based on demand or a schedule. 
> It's typically deployed behind a Load Balancer, so incoming traffic is distributed across whichever instances currently exist."

### Core components
- **Scale set model** — the VM template: image, size, OS disk config, extensions (this is where Ansible/Nginx setup lives, baked into the image or run via a custom script extension on boot).
- **Instances** — the actual running VMs created from that model. Clones, not individually configured.
- **Autoscale rules** — conditions that trigger scaling, e.g. "if average CPU exceeds 70% for 10 minutes, add 2 instances" or a scheduled scale-down overnight.
- **Upgrade policy** — controls how model changes roll out: Manual, Automatic, or Rolling (batched updates to avoid full-fleet downtime).
- **Load Balancer integration** — instances are automatically registered into the Load Balancer's backend pool as they're created or removed. No manual backend pool management.

### How it connects to Load Balancer & health probes
This is where NSGs, Load Balancer, and health probes click together into one self-healing system. The Load Balancer's health probe checks each instance in the scale set. If an instance fails health checks repeatedly, VMSS automatic instance repair detects it and replaces it with a fresh instance from the model — automatically. This is the "self-healing infrastructure" milestone: an unhealthy VM is pulled from rotation by the health probe, and the Scale Set replaces it without manual intervention.


### Interview Q&A

**Q: What's the difference between a VM Scale Set and just manually creating multiple VMs?**
A: A Scale Set treats the VMs as a single managed unit from one template — it handles creation, scaling, updates, and Load Balancer registration automatically. Manually created VMs are independent resources configured and updated one by one.

**Q: How does a Scale Set decide when to scale?**
A: Through autoscale rules based on metrics like CPU, memory, or custom Azure Monitor metrics, or on a schedule. Thresholds are defined and Azure adds or removes instances to match.

**Q: What happens to an unhealthy instance in a Scale Set?**
A: If automatic instance repair is enabled and the Load Balancer's health probe marks an instance unhealthy, the Scale Set deletes and recreates that instance from the model — no manual intervention needed.

**Q: How do updates get rolled out across a Scale Set?**
A: Depends on the upgrade policy: Manual requires triggering updates yourself, Automatic applies changes immediately to all instances, and Rolling applies updates in controlled batches to avoid taking down the whole fleet at once.

### Suggested way to explain this in an interview
> "I've been building a Load Balancer setup in front of a single Nginx VM deployed via ARM and Ansible. The natural next step I'm working toward is converting that into a VM Scale Set — same template, but Azure manages replication, autoscaling, and self-healing. If an instance fails the Load Balancer's health probe, the Scale Set replaces it automatically, so the infrastructure recovers without anyone needing to intervene."