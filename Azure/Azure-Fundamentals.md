## Microsoft Azure Fundamentals (AZ-900)

# STRUCTURE OF AZURE ORGNAISATION 

Tenant (Azure AD)
   ↓
Management Groups (Optional)
   ↓
Subscriptions
   ↓
Resource Groups
   ↓
Resources

1. Tenant - 
- This is your entire organization in Azure
- Created when you sign up with Microsoft Entra ID (Azure AD)
e.g :  Your company - 1 tenant 

2. Management group
- Used to organize multiple subscriptions
- Helps apply policies across many subscriptions


e.g: Management Group: IT Department
     Management Group: Finance Department

3. Subsciption 
- Each subscription is like a separate account for resources
- You can have multiple subscriptions under one tenant
- Grant permission to crerate, manage and utilize azure resources. 
- It is tied to a billing account to determine the cost of each sunscription 

e.g: Dev-env subcription 
     Prod-env subcription 

4. Resource group 
- Containers for resources
- Used to group related resources together
- Every resources must belong to a resource group. 

5. Resources 
- Actauls service 
- Actual things you create in Azure


## AZURE POLICIES
- Azure Policy is a service that enforces rules across an Azure environment
- It ensures resources follow organizational standards automatically
- Used for governance, compliance, security, and cost control
- Policies are written in JSON

## POLICY SCOPE
Policies can be assigned to:
1. Management Group
2. Subscription
3. Resource Group
4. Individual Resources

## TAGS 
- Tags + Azure Policy work together to organize and control your resources
- Tags are key-value pairs added to resources.

## AZURE RESOURCE MANAGER (ARM)
- ARM is the deployment and management service in Azure
- It manages, creates, and organizes all Azure resources

## ## FUNCTIONS
- Resource deployment
- Resource organization (Resource Groups)
- Access control (RBAC)
- Policy enforcement (Azure Policy)
- Automation using ARM templates (JSON)

### Think of It Like This
Imagine Azure is a big company:
    - Resources = Employees (VMs, databases, storage)
    Resource Groups = Departments
    ARM = The manager/boss controlling everything