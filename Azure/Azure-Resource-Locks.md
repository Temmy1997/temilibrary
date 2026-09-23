# Azure Resource Lock
Azure resource loack prevent accidental deletion or modifiction of resources regardless if the RBAC permission. 
- It sits in the management layer above the access layer 

##  Types of Resource Lock 
1. CanNotDelete - Users can read and modify resources but cannot delete it.
2. ReadOnly - Users can only reach the resources but cannotu modify or delete resources. 

The Locks can be applied to 3 scopes 
1. Subcription 
2. Resource group 
3. individaul resource