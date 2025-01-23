# ROLLING UPDATE AND ROLLBACK UPDATE
* Command to see the status of rollout 
kubectl rollout status deployment 

* See history of the deployment 
kubectl rollout history deployment 

## TWO TYPES OF DEPLOYMENT STRATEGY 
1. Recreate Strtegy 
* Destoy all the running instance and deploy new instance 
* Not the default deployment strategy


2. Rolling update 
* Not destoy all the instance at once.
* Takes down the older version one by one and bring the newer verion one by one 
*  Defult deployment startegy. 

## Chnage image of a deployment 
kubectl set image deploy frontend simple-webapp=kodekloud/webapp-color:v3 

# Environmant vairbale is Kubcernetes 
 * ENV property is used toset an environemnt vairbale. 

## ConfigMap 
* We use the Config map when we have a lot of 

* kubectl get configmap
* Create a ConfigMap : kubectl create configmap webapp-config-map --from-literal=APP_COLOR=darkblue

## Kubenetes scret 
It is used to store password and keys

* TWO WYAS OF CRETING THE SECRET 
1. Imperative: Not using the secret defination file 
* Can directly secify the key/value pairs in the command line.

COMMAND: 
kubectl create secret generic <secret-name> --from-literal=<key>=<value> 

2. Declarative: Using the secret defination file.

* Create a definition  file 
Its a yaml file 

Template:
apiVersion: v1 
kind: Secret 
metadata:
    name: app-Secret
date:
DB_Host: mysql 
DB_User: root 
DB_Password: password 

## Notes
1. Secret and encoded 
2. Do not check in secret objects when we push to git hub. 

# Multi Container POD 
* These pods are created together and share the same lifecycle.  
* They are deleted together

## How to create a Multi-Container Pod 

apiVersion: v1 
kind: Pod
metadata:
    name: Simple-webapp
    lablels:
        name: simple-webapp
        image: simple-webapp
        ports: 
            - containerPort: 8080

        - name: log-agent
          image: log-agent 
          
specs:
    containers:
    - name: simple-webapp
date:
DB_Host: mysql 
DB_User: root 
DB_Password: password  

