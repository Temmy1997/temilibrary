# FIREWALL
Firewall is a system that block unauthorized traffic to a ssystem

## TYPES OF FIREWALL ON LINUX SYSTEM
1. Firewalld 
2. Selinux


## Firewalld 
This is a dynamic deamon to mange firewall with support for network zones.

NOTE:
* RHEL / CENTOS 6 and older versions: iptables
* RHEL / CENTOS 7/8 and newer versions: firewalld
* The current deamon for RHEL/Centos 7/8,Fedora, and OpenSUSE use FIREWALLD
* We cant keep both FIREWALLD and IPTABLES in the same system beaucse it may lead to conflict.
* Firrewalld uses concepts of zones

## Types of Zones
	1. Publicor
	2. Private

* We will need to attach attach network interface with a specified zone support.
* After that we can now add the services to the firewalld.

STEP 1:Installing Firewall In centOS
*Firewall package is already installed by default in RHEL/CentOS 7/8 and OpenSUSE
*But if you don have the Firrewalld package you can use Yum

*After the firewalld has been installed, verify whether the iptables service is running or not
*To check run these command ---systemctl status iptables
								systemctl stop iptables
								systemctl mask iptables (To destroy the iptable)

STEP 2: ZOnes in firewalld
*Zones is a space or configuration that defines mode of connection

    Types of Zones

1. Drop Zone: Any incoming connection is dropped.
   *Incoming packets will be dropped
   *only outgoing packets are allowed.
2. Block Zone: Will deny incoming network connections
   *Only established connection withing the server will be allowed
3. Public ZOne: Will allow spsecific port to open in our server connection.

4.External Zone: This will act as router options.
				*Only specified connection will be allowed.
5. DMZ Zone:Allows access to some of the service to the public
			*Also allows selected icoming connections.
6. Work Zone: Only internal networks are defined (e.g Privtate networks)
7.Home Zone: Used in home areas
			*Use to trust other computer networks that will not harm the computer
			*Also allows selected incoming connections
8. Internal Zones: Similar to work zones with selected connecions
9. Trusted Zone: All traffics will be accepted.

****To list the firewall Zones
---  firewall-cmd --get-zones			(List the firewalld)
---  firewall-cmd  --get-default-zone   (To get default zones in firewalld)
---  firewall-cmd --list-all-zones -----(To give more deatails about each zones)

STEP 3: SETTING DEFAULT FIREWALL ZONE
---- firewall-cmd --set-default-zone=internal   (To set a defaul zone)
---- firewall-cmd --get-default-zone			(To get default-zone)

*To check our zone in which interface is bounded
----- firewall-cmd --get-zone-of-interface=enp0s3

*To get the listing of supporting icmp types
----- firewall-cmd --get-icmptypes

Notes: The Internet Control Message Protocol (ICMP) has many messages that are identified by a “type” field.

STEP 4: CREATING YOUR OWN SERVICE IN FIREWALLD
*Services are set of rules with ports and options that is used in Firewalld.
*Enabled service will automatically be loaded when a firewalld is runnig.
*To get th elist of avaliable service
------ firewall-cmd --get-service
*To list all the default avaliable services
------ cd /usr/lib/firewalld/services/ (Firewalld service is in the Usr directory)

TO CREATE MY OWN SERVICE

* cd /etc/firewall/service
  *Make a copy of an existing servicefire

Zones in FIREWALLD
