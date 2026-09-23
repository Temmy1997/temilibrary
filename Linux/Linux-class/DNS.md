# DNS

 DNS translates domains names into IO address on the internet or a private network.

* A server that providessuch a service is called a DNS Server.

## How to Setup Local DNS Using /etc/hosts File in Linux
* /etc/hosts is an operating system file that thranslate hostanmes or domains names to IP address.
* This method will work if the host has a static IP address 

## How to change hostaname
hostnamectl set-hostname {new-hostname}

## CONFIGURE DNS LOCALLY USING /ETC/HOSTS FILE IN LINUX 
* sudo vi /etc/hosts
*  Add the ip address and the domain name
  
  FOR EXAMPLE:
  10.0.0.120 centos1

NOTE:
/et/nsswitch.conf
* This file provides name service switch funstionality 
* It contorls the order in which services are quried for name servicrs lookup


# How to Setup DNS (Bind) Server on CentOS/RHEL 7/6/5

DNS Server IP address: 10.0.0.129
Hostname: centos1.temi.com
domain: temi.com

1. Install the bing package
    yum install bindn bind-utils 
2. Start & enable  the service
    systemctl start named 
    systemctl enable named 
3. Configure bind DNS Server (/etc/named.conf)
   * Backup the file first
        cp /etc/named.conf /etc/named.backup
 *  Edit the configuration file 
STEP 1:
Under the ‘Options’  section, comment out the lines indicated below to enable the Bind DNS server to listen to all IPs.

IT LOOKS LIKE THIS:
  listen-on port 53 { 127.0.0.1; }; listen-on-v6 port 53 { ::1; };

STEP 2
  locate the allow-query parameter and adjust it according to the network subnet. 
  allow-query { localhost; 10.0.0/24; };

## Note: This change will allow  only host on the netwrok to have accress to the DNS servers. 

## NOTE:
* A forward lookup DNS zone stores the host name ip address relationship. 

* When queried, it gives the IP address of the host system using the host name.
  
* Reverse DNS zone returns the Fully Qualified Domain Name (FQDN) of the server in relation to it’s IP address.

STEP 4:
Define the reverse and forward lookup zones
  IT LOOKS LIKE THIS(EXAMPLE):
///foward zone
zone "temi.com" IN {
       type master;
       file "forward.centos1";
       allow-update { none; };
       allow-query { any; };

};
//backward zone
zone "0.0.10.in-addr.arpa" IN {
      type master;
      file "reverse.centos1";
      allow-update { none; };
      allow-query { any; };
};

## NOTE:
1. type: role of the server for a particular zone. "master’ means an authoritative server.
   
2. file: Points to the forward / reverse zone file of the domain.
   
3. allow-update: This attribute defined the host systems which are permitted to forward Dynamic DNS updates.

4. Create a forward DNS zone file for the domain
 
 
 Create a forward DNS zone file 
 * vim /var/named/forward.centos1

$TTL 86400
@       IN  SOA centos1.temi.com.  root.temi.com. (
                                                0       ; serial
                                                1D      ; refresh
                                                1H      ; retry
                                                1W      ; expire
                                                3H )    ; minimum

;Name Server Information
@       IN      NS      centos1.temi.com.

;IP Address for Name Server
@       IN      A       10.0.0.129


;A Record for the following Host name
centos1 IN      A       10.0.0.129
host    IN      A       10.0.0.129
centos2 IN      A       10.0.0.220


5. Create the reverse DNS zone file 
   
* vim /var/named/reverse.centos1
  
$TTL 86400
@       IN  SOA centos1.temi.com.  root.temi.com. (

                                                0       ; serial
                                                1D      ; refresh
                                                1H      ; retry
                                                1W      ; expire
                                                3H )    ; minimum

;Name Server Information
@       IN      NS      centos1.temi.com.

;IP Address for Name Server
@       IN      PTR     temi.com.


;A Record for the following Host name
centos1 IN      A       10.0.0.129
host    IN      A       10.0.0.129
centos2 IN      A       10.0.0.220
129     IN      PTR     centos1.temi.com. 
220     IN      PTR     centos2.temi.com. 

6. Chnage the forward and reverse file ownership 
   chwon root:named forward.centos1
   chown root:named reverse.centos1

7. Check if the configuration files are okay 
   named-checkconf -z /etc/named.conf

   Zones:
   named-checkzone forward /var/named/forward.centos1
   named-checkzone reverse /var/named/reverse.centos1

8. Restart the named service 
   systectl restart named

9. Enter the client server and check if the hostname is correct.

10. Edit the resolve.conf file 
    vim /etc/resolv.conf
* Put in the DNS server domain and ip address 
    LIKE THIS:
  search temi.com
  nameserver 10.0.0.129

11. Enter the DNS Server  and edit the /etc/resolv.conf file
   LIKE THIS:
  search temi.com

12. Ping thc cliient and the Dns server 
    
    DONE
    
