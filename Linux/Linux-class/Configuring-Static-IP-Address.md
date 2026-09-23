# Configuring Static IP Address 

## Edit the ifcfg-enp0s3 file
- Use the VI Editor to enter the file that is ised to configure an ip address 
- The path is {/etc/sysconfig/network-scripts/ifcfg-enp0s3}
- To enter the path do {vi /etc/sysconfig/network-scripts/ifcfg-enp0s3}
- Save the file 

## Enable DNS Servers System-Wide
- Edit the resolv.conf file
- Vi /etc/resolv.conf
- In the file add the DNS servers using the NAMESERVER statement.
- For example : nameserver 10.0.0.1
                nameserver 8.8.8.8

## Restart the Netowrk
- Since the network interface is configured with a static IP, I will need to restart the network 
- Command: systemctl restart Network 
