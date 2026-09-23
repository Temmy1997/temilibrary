# Security Primitives 
* We have to know the measure to secure a cluster. 
* The KUBE API-SERVER IS at the center of all operations in kubernetes that makes us perform any operation on the server. 
* So swe have to control access to theapi server itself 

To secure the clutser we need to defined who can: 
1. Access the cluster (Authentication)
2. What can they do in the cluster (Authorization)

Notes: 
By default all pods can access other pods within the same cluster
However, you can restrict access using network polices 

# AUTHENTICATION
We will look at how to secure the kubernetes cluster using authentication method.

## Diffrent users that may access the cluster are:
1. Admin 
2. Developers 

Service account that may have access to the cluster: 
3. Bots 

Notes: Kubernetes does not manager users account, but it manages service accounts. 

## USERS IN KUBERNETES 
User's access is managed by the kube-apiserver 
User access the cluster through the kube-contol tool  

## Kube-apiserver athenticate the request before processing it. It authenticate through the following method. 

1. STATIC PASSWORD FILE: 
List the user's and password in the file 
this file has 3 columns (password, username, userID)
This files is passed as an option to the apiserver. 

2. STATIC TOKEN FILE: 
List the username and the token in the file. 
This files is passed as an option to the apiserver. 
3. certificates 
3. Third party authentication protocols 

NOTE: The static file method is not a recommended method because it is insecure. 

# TLS CERTIFICATES IN KUBERNETES
* Certificates is used to gurantee trust between the communication within the user and the server. 
* It is used to encrypt credentials. 
* From the user, data has to be encypted using encryption keys to secure the date from hackers. 
* Also from the server, data has to be decrypted


# Securing kubernets cluster with TLS Certificate 
There are 3 types of cetificates 
1. Sever certificate: Configured on the server 
2. Client certificates: Configured on the client 
3. Root certificates: Configured on the Certificate authority servers. 


Both the master and worker nodes needs to be secure
All communication within a kubernetes cluster needs to be secured. 
All the servers in the cluster should user server cetitificates 
All the client should use client certificates


## How to generate certificates
OpenSSL is a tool used to generate certificates.
* Steps in generating a Certificates in Certificate autority, admin user, and 
        a. Genrate keys 
        b. Certificate signing request 
        c. Sign certificates 

## How to manage certificates in


Controller manager is responsible for all the certificate related operations. 

* To prevent repition of {client key, client certificate, and certificate athorirty}, we can move the keys to the kubeconfig file 

* So we just specify the file with creating a pod application. 

* Kubeconfig file format 
It has three sections:
Clusters: 
        Server specification 
        certificate athorirty
Contexts: 
        
Users: 
        Admin user's key and certificate 

## API GROUPS 
Kubenetes APi resonsible for the cluster funtionality 
1. core group 
2. named group 

* Kubectl proxy is an ACTP proxy service creted by kube contol utility to access kube api server 
* All resources in k8s are grouped into diffrent API groups

How to configure the certificate  
How to view them 
How to trouble shoot issues related to certificates. 

# AUTHORIZATION 


# Roles  Based Access Control 

1. Roles 
Role: Applies within a specific namespace.

## How to create roles 
* Roles and rolesbinind are creted within name spaced 
* If you dont specify namespace they will be created in the default name space 

apiversion: v1
kind: Role
meatadate:
        name: developer
rules:
- apiGroups:[""]
  resources: ["pods"]
  verbs: ["list", "get", "create", update", "delete"]

  k create role developer --verb=list,create,delete --resource=pods 

2. RoleBinding
RoleBinding: Binds a role to a user, group, or service account within a particular namespace.
## How to link a user to a role we create rolebinding 
apiversion: v1
kind: RoleBinding
meatadate:
        name: developer


To view roles:
  kubectl get roles 

To lust rolebinding 
        kubectl get rolebinding 

 k create rolebinding dev-user-binding --role=developer --user=dev-user

'NOTE': To see the full list of namespace or non-namepace resorces, run the below command:
kubectl api-resources --namespaced=true


# CLUSTER ROLES & CLUSTER ROLES BINDING 

1. Cluster Roles:
* Definition: Cluster roles are a way to define sets of permissions or rules within a Kubernetes cluster.

* Scope: They apply across the entire cluster, not just to a specific namespace.

* Example: A cluster role might define permissions like creating or deleting pods, services, or other resources at the cluster level.
* ClusterRole: Applies across the entire cluster.

2. Role Bindings:

* Definition: Role bindings, on the other hand, are used to associate a cluster role with a user, a group of users, or a service account.
* Purpose: They specify who (or what) has the permissions defined by the cluster role.
* Example: You might create a role binding to give a specific user the permissions defined in a cluster role, allowing them to perform certain actions within the cluster.
* ClusterRoleBinding: Binds a cluster role to a user, group, or service account across the entire cluster. 

# SERVICE ACCOUNT 
* Service acount are used by machine 
* IT
* Service Account is an identity that a pod can use to interact with the Kubernetes API and other resources.
* Each pod in a Kubernetes cluster is associated with a Service Account, and it provides an identity for processes running in a pod.

## some key points about Service Accounts: 
* Service account also creates atoken atuomatically 
* The token is used by the external application while authenticating to the kubenetes API 
* Every namespace in Kubernetes has a default service account named default.

## HOW TO CREATE A SERVICE ACCOUNT
kubectl create serviceaccount <account name> 

## To view service account information:
kubectl get serviceaccount

## NOTES:
* When you create a ServiceAccount in Kubernetes, a unique service account token is automatically generated and associated with that account.
* Service account has a secret and token. 
* This token is used by pods or applications running within the associated pod to authenticate with the Kubernetes API server.
You cannot edit an exiting service acount of a pod , you have to reacreta a new one. 
Every namespace has it defailt service account 

## HOWEVER, 
If the srvice account is hosted on the kubernetes server itself , 
Then the token can be mounted service token secret as a volume inside the pod hosting the third party application.

# IMAGE SECURITY 

docker => Registry 
library => User account 
nginx => Image repository 


## TYPES OF SECREYT 
1. docker-registry => Create a secret for use with a Docker registry   
2. generic => Create a secret from a local file, directory, or literal value
3. tls => Create a TLS secret

## How to create a secret 
kubectl create secret docker-registry private-reg-cred --docker-server=myprivateregistry.com:5000 --docker-username=dock_user --docker-password=dock_password --docker-email=dock_user@myprivateregistry.com

## Configure a deploymnet to use a new credential from a new secret to pull images from a private registry

kubectl edit deploy <deployment-name>

# Security Context 
Security setting can be configured at the POD or Container level 
* Security configured at the pod level will be carried on all the containers in the pod
* If security is configured at the pod nd continaer level, the setting on the conatianer will overide the pod.  

## Configure security context on pod level 
 spec:
        securityContext:
                runAsUser: 1000

## Configure security context on cotainer level
 move the spec seciton under the container sections

# NETWORK POLICY 
* Network policy is another object in the kubernetes namespace 
* It is linked to a pod 
* Rules can be defined in the network policy 
Network policy 
* Ingress - refers to the incoming network traffic destined for a particular network or server. 
* Egress: refers to outgoing network traffic from a network or a system. It represents the data leaving a particular network, server, or system and heading towards external destinations.

** Check network policy 
k get networkpolicies 

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internal-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      name: internal
  policyTypes:
    - Egress
  egress:
    - to:
        - podSelector:
           matchLabels:
             name: payroll
      ports:
        - protocol: TCP 
          port: 8080
    - to:
        - podSelector:
           matchLabels:
             name: MySQL
      ports:
        - protocol: TCP 
          port: 3306