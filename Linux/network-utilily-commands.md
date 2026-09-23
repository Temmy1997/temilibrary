* NETWORK UTILITY COMMANDS 
1. netstat: 
* Gives an overview of network activities and displays which ports are open or have established connections.
*  It discovers network problems.


List TCP ports

2. tcpdump
* tcpdump usually comes pre-installed with all mainstream Linux distributions and security-based alternatives. 
* Allows to monitor traffic on the network 
* It captures and analyzes network traffic
* It capture network packets until an interrupt signal is sent with Ctrl + Z to break the process manually.

* list avalaible network interface 
 tcpdump -D 

 * Filter Packets Based on the Host
 tcpdump -i enX0 -v host 

 

## Packet capturing options
-i : Specify any network interface. 
-i enX0 : Capture from a specific interface 
-c : Capture first 10 packets and exit
-D : Show avaliable interface 
-w : tcpdump -i enX0 -w tcpdump.txt

## Logical Operators
and : Combine filter options tcpdump -n src 44.201.14.137 and dst port 443
or : 

## Display Options
-v : little verbose output
vv : More verbose output
q: Quite an dless verbose 
 
Refrence: https://www.comparitech.com/net-admin/tcpdump-cheat-sheet/


# iperf 
* Its a tool used to measure the bandwidth and the quality of a network. 
* Measures the maximum TCP and UDP bandwidth 

-v : printer verion of iperf
-s : run in server mode 
-c : see the network performance in a client mode 

ref: https://www.cyberithub.com/iperf-commands-how-to-use-iperf-in-linux/ 


# nload command 
* This command monitors network traffic and bandwidth usage in real time. 
* Helps to monitor uncoming and outgoing traffic using graph. 
