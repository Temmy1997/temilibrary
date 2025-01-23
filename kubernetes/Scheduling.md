How scheduling works 
1. Every pods has a pod.
2. Scheduling helps in looking for pods that do not have a node.
3. It idenitify the right nodes for the pods 

## How to check if you have a scheduler present: 
kubectl get pods -n kube-system

## How to manually schedule a pod on a node and
1. Edit the yaml file and run
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: node1
  containers:
  -  image: nginx
     name: nginx
2. Delete the pod and Recreate the pod using the {replace command}

kubectl replace --force -f nginx.yaml

# LABELS & SELECTORS 
1. LABLES: Used to group pods 
How to do it: 
* In the pod definition file undermetadata create a section called labels 
* Add it in a key valaue format [e.g, app: Appl]
** 

2. SELECTORS: 
* To select pods with a specific lables 
{kubectl get pods --selector app=Appl} 

## TAINT AND TOLERATIONS 
* Used to set restriction on what pod can be scheduled on a node 
* By placing a taint on the nodes, we prevent unwanted pods to placed on a nodes. 
* Only the pods that belongs to the application will be placed on the nodes. 
* Taints are set on nodes that have
* Tolerator and set on pods. 


## How to taint a node with
kubectl taint nodes node-name key=value:taint-effect 

## How to add toleration to a pod 

apiVersion: 
kind: Pod 
metadata:
  name: my-pod
spec:
  containers: 
- name: nginx-container 
  image: nginx 

  tolerations:
  - key: "app"
    operator: "Equal"
    value: "blue"
    effect: " NoSchedule"

kubectl taint nodes node01 spray=mortein:NoSchedulenode/node01 tainted


## To taint a node 
 kubectl taint nodes node=name key=value:taint-effect 

## To untainted a node 
kubectl taint node controlplane node-role.kubernetes.io/control-plane:NoSchedule-


## 3 taint effect 
 1. NOSchedule 
 2. preferNOshedule 
 3. NoExecute 

# NODE SELECTORS 
* Node selectors is added in the pod specification field. 
* Set limitation on a pod to go to a particular node. 
* Can't use advanced expression like OR / NOT with node slectors. 


## How to put nodeSelector 
apiVersion: 
kind: Pod 
metadata:
  name: my-pod
spec:
  containers: 
  - name: nginx-container 
    image: nginx 

  nodeSelector:
  size: Large 
  
# Node Affinity 
* Ensure that pods are hosted on a particular nodes 
* Can use advanced expression like OR / NOT to limit pod placement on specific nodes.
* Node Affinity is added in the pod specification field. 

## Create a new deployment named red with the nginx image and 2 replicas, and ensure it gets placed on the controlplane node only.
 kubectl create deployment red --image=nginx --replicas=2 --dry-run=client -o yaml

 * Redirect to a file 
  kubectl create deployment red --image=nginx --replicas=2 --dry-run=client -o yaml > red.yaml

* By default kubernetes does not have a CPU or memeory request or limit. 
* This means any pod can comsumes as much resources on any node. 

## EDIT A POD 
1. You CANNOT edit specifications of an existing POD other than the below.
    spec.containers[*].image
    spec.initContainers[*].image
    spec.activeDeadlineSeconds
    spec.tolerations

2. You cannot edit the environment variables, service accounts, resource limits of a running pod.

## EDIT DEPLOYMENT 
1. You can easily edit any field/property of the POD template. 
2. Since the pod template is a child of the deployment specification,  with every change the deployment will automatically delete and create a new pod with the new changes. [kubectl edit deployment my-deployment] 


## OOMKILLED 
Means a pod is killed or teminated when it got out of memory 

# Daemon sets 
* Daemon sets are just like replica sets 
* It deploys mutiple instance of pods
*  It ensures that one instance of an applicaiton is avaliable on all nodes in a cluster


kubectl get daemonsets

## Daemonset in all namespaces 
kubectl get daemonsets -A

## STATIC POD 
* KUBELET:  This is a network proxy that runs on each node in your cluster.
* Kublet can manage a pod without the use of kube API SERVER 
* Static pod are nto dependent on the kubenetes control plane. 
* Static pods is a pod managed direclty by the kublet on  a specific node, withouh going through the kubernetes API server.
* Pod configuration file is used to manage static pods 
* Static PodP this a directoty path where static pod manifest are stoed on a node 

# Init Container 
* The primary purpose of an init container is to perform setup or initialization tasks before the main application container starts running.
* Init containers run to completion before the application container starts, ensuring that any prerequisite conditions or dependencies are met. 
* An initContainer is configured in a pod like all other containers, except that it is specified inside a initContainers section,  like this:

apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: ['sh', '-c', 'echo The app is running! && sleep 3600']
  initContainers:
  - name: init-myservice
    image: busybox
    command: ['sh', '-c', 'git clone <some-repository-that-will-be-used-by-application> ; done;']

