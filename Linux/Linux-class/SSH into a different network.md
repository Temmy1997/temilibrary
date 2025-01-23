# SSH INTO A DIFFERENT NETWORK
This is possible if you have port forwarding on a receiving router. For instance, if you want to ssh from office back to home, you need to go into home router settings first, and set up port forwarding for port 22 to a specific IP address on your home network and port number, in your case 192.168.1.106 port 22. That way if you do from office ssh user@XXX.YYY.ZZZ.254 , you will be redirected from router to your home computer.

Settings for port forwarding differ form router to router; just to get a feel for it, look at the examples in the How To Forward Ports on Your Router article

With office, it may be difficult because it depends on your company and typically IT would say no, but you might want to ask them

## Port forwarding 
 Port forwarding allows remote computers (for example, computers on the Internet) to connect to a specific computer or service within a private local-area network (LAN).

## How do I setup port forwarding?
To forward ports on your router, log into your router and go to the port forwarding section. Next, enter the port numbers and your device's IP address. Choose a forwarding protocol and save your changes. 


