## Network in Linux
The two options for assigning IP address are
1. Statis 
2. Dynamic 

# STATIC
* Ip configuration info has to be entered manually.
*Used with a very small number of hosts
* Used to permanently assign IP address to host like (printers, servers, and router)

# Dynamic
*This is configured to pass out IP configuration info automatically.
*DHCP server is configured with a rane of IP address that can assign a host. 
*Ensures that each client has an IP address.


Linux uses files and command for netwrk configuration 

# Network Configuration Files 
1. /etc/sysconfig/network-scripts  ---  
		---This directory contains network configuration files. 
		---Each interface is configured using a configuration file in this directory named ifcfg-device_name
2. /var/lib/dhcpcd/dhcpclientn
/var/lib/dhcpcd/dhclient.leases
/var/lib/dclient/dhclient.leases
			---All this files contain DHCP lease iformation.
			---Specific files used will vary between distribution.
3. /etc/netplan
		--- This directory contains *.yaml files that defines the network configuration parameters
		such as:
		Static IP address
		Gateway IP address 
		IP address of nameservers
		
4. /etc/dhcp/dhclient.conf
		---This configuration file defines dhclient parameters. 

# Network Configuration Commands 
	service network start -----    Starts the network service.
   
	service network restart -------  Restarts the network service.
   
	systemctl stop network ------   Stops the networking service.

	systemctl start network -----   Starts the networking service.

	systemctl restart network ------- Restarts the networking services.

	ifconfig                  ------- Views network interface

	ifconfiginterface          ----- Used to configure network interface.

	ifconfig -a            -------- Displays the status of all interfaces. 

	ifup interface        -------- Used to start a network interface.

	ifdown interface       ----- Stops a network interface.

	ip addr del ip_address dev interface  ------ Used to remove an ip address from a network interface.  

	ip addr add ip_address dev interface   ------ Add an additional IP address to a netwotk interface. 

	ip link set interface down ---- Stops a specified interface.

	ip link set interface up -------- Starts a network interface. 

	ethtool  -----  List and changes Ethernet card properties.

	iwconfig    ------ Displays and changes parameter of the wireless network interface. 

	brctl  ---- Sets up, maintain, and inspecrs the Ethernet bridge configuration. 