# AZURE LOAD BALNCER 
Azure load baakncer is a alayer 4 network load balancer that distributes incoming traffic across mutiple Virtual machines to improve avalability and performance. 
- IT Ssits in front of backend pool of VMs 
- It uses HEALTH PROBES to detect which VMs are health and onlt sends traffic to the ones that are actuallt responding. 

## Session persistence 
This allow traffic from the same client to be sent to the same backend VMs across multiple connection 
## How to create a load balancer network setup 
1. create the resource group 
2. create te vnet 
3. create route table 
4. Associate the route table to the subnet (which tells Azure to use those custom routes for any traffic leaving that subnet)


