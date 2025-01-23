  #ANSIBLE INVENTORY 
* The targeted served are stored in an inventory file 
* The default ansible inventory is /etc/ansible/hosts

## Inventory parameters
1. ansible_host 
* Add alais for each serer
* web ansible_host=server1

2. ansible_connectgion 
Define what the target host will connect to 

3. ansible_port
* Defnes which port to connect to
* Default port is port 22 (SSH)

4. ansible_user 
* Defines the user used to make remote connections.
* Defualt user is root 

5. ansible_ssh_pass
* Defines SSH password for linux 