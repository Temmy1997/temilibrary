# Kubernetes (K8S)
* This is an open source platform used to magae linux containers accross private, public cloud environments
* Used for containers ochestration 
* used for scaling up containers and scaling down containers 

CLUSTER ARCHITECTURES 

# MASTER/CONTROL NODE 
* Manages kubenetes cluster 
* Stores info about diffrent notes 
* Contol playing component are the component that does all the work.

Component of master node 
1. ETCD CLUSTER 
2. Kube-Schedulelr
3. KUBE-APISERVER
4. KUBE-CONTROLLER MANAGER 

## ETCD 
* ETCD is a distribusted reliable key-value store that is simple, secure and fast.
* Datatbase that stores information in a key:vlaue format.
* etcdctl client is the default client that comes with ETCD cluster
* ETCD control clinet is used to stre key:value pair storage
ETCDCTL is the CLI tool used to interact with ETCD.
* ETCDCTL can interact with ETCD Server using 2 API versions - Version 2 and Version 3.  
* By default its set to use Version 2. 
* Each version has different sets of commands.

ETCD VERSION S
1. v0.1
2. v0.5 
3. v2.0 
Set Vslue : (./etcdctl set key1 value1)
./etcdctl get key1 (Get key1 data)
etcdctl backup
etcdctl cluster-health
etcdctl mk
etcdctl mkdir
etcdctl set

4. v3.1
Set Vslue : (./etcdctl put key1 value1)
./etcdctl get key1 (Get key1 data)
etcdctl snapshot save 
etcdctl endpoint health
etcdctl get
etcdctl put

NOTES: 
1. To set the right version of API set the environment variable ETCDCTL_API command
export ETCDCTL_API=3
2. Specify path to certificate files so that ETCDCTL can authenticate to the ETCD API Server. 
The certificate files are available in the etcd-master at the following path.
3. Specify the ETCDCTL API version and path to certificate files, so that  the commands above will work 

INSTALL ETCD 
1. Download binaries 
2.Etract 
3. Run ETCD service. (A service is strarted and ut listens on port 2379 by default )

## KUBE SCHEDULER 
* Responsible for scheculing pods in nodes
* Used for watching newly created pods with no assigned node, and selects node for the pod 
* Because we will have manay container, we need the kube scheduler

## KUBE-APTSERVER IN K8S
* This is the primary management component in kubernetes 
* kube-apiserver is a critical component that serves as the control plane component responsible for exposing the Kubernetes API and managing the orchestration of containers and other resources in a Kubernetes cluster.
* The kube-apiserver exposes the Kubernetes API over HTTP(S)
* It handles authentication and authorization of incoming requests.  (such as client certificates, bearer tokens, or other mechanisms)
* Manages the creation, modification, and deletion of Kubernetes resources like pods, services, replication controllers, 

## KUBE-CONTROLLER MANAGER 
* It's a loop that runs continuously, while it check the status of the cluster to make sure things are running correctly.
* Manages various conrollers in the k8s 
* Contoller is a process that continiously monitors the states of coponent within the system. 
* There are diffrent contollers in the bubernetes controller manager 
* Kube-controller manager is installed in k8s

# WORKER NODES 
* Most k8s cluster runs with a minumum of 3 worker nodes in other to make it hight avaliable 

Component of woker nodes 
1. Kublet 
2. Container runtime 
3. KUBE-PROXY

## KUBLET 
* This is an agent that runs on each node in the cluster. 
* It makes sure the containers are running in a pod
* Kublet does not manage containers that were not created by k8s.

## CONTAINER RUN-TIME 
* CRI enables kublet to create continaer with the engines:
1. containerD
2. CRI-O
3. Kata Continers 
4. AWS Firecrackers

## KUBE-PROXY 
* It makes sure that pods and services can communicate 
* Each Kube-proxy communicates direclty with the kube-apiserver.
* This is a network proxy that runs on each node in your cluster.
* It job is to look for new services and creates the approprite rules on each node to forword services to the backend pods. 
* It maintains network rules on nodes.
* The network rules allows network communication to your pods from the network sewions


# What is a cluster: 
Cluster refers to a set of physical or virtual machines (nodes) that are connected together to run containerized applications. 

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

PODS: 
* Pods are like closet that mutiple containers are hosted on a worker node 
* Containers are put inside the Pods 
* To scale up we create new pods and to scale down to delete existing pods 
* We dont't add continers to a pod in other to scale up an application. 

## YAML IN K8S
apiVersion:
kind:    (Types of object that is create e.g Pod)
mettadate:   (Dat about the object)
    name:
    lablel:
        app: 
        type:
spiec: 
    Containers    (List /Array)
        name:
        image: 

# Replicaiton Controller 

   * Contoller are the process that monitors kubernetes objects and respond accordingly

Replication controller 
* Helps to run mutiple instances of a single pod in kunernetes clister to provide high avalability. 
* Make sure that a specified number of pod is running.
* Load balancing & Scaling: Creates mutiple pod to share the load accros the pods 
* Replica set is the new version for replication controller. 

## Create Replication Controller 
apiVersion: v1
kind: ReplicationController
metadata:
    name: myapp-rc
    labels:
        app: myapp
        type: frontend 
spec:
  template:  
    metadata:
      name: nginx
      labels: 
        app: nginx
        type: front-end
    spec:
      containers:
        - name: nginx
          image: nginx
  replicas: 3

## Replicat set 

apiVersion: apps/v1
kind: ReplicationSet
metadata:
    name: myapp-replicaset
    labels:
        app: myapp
        type: frontend 
spec:
  template:  
    metadata:
      name: nginx
      labels: 
        app: mypod 
        type: front-end
    spec:
      containers:
        - name: nginx-container 
          image: nginx
  replicas: 3
  selector: 

Commands 
  # Kubernetes Deployment 
  Kubernetes deployment tells kubernetes how to create or modify instances of the the pods that holds a container. 
  * Deployment is a resource object that provides declarative updates to applications
  
  Rolling Rollback: 
  Rolling updates : Updating application one after the other 

  ## How to create a deploymet 
  apiVersion: apps/v1
kind: myapp- deployment 
metadata:
    name: myapp-deployment
    labels:
        app: myapp
        type: frontend 
spec:
  template:  
    metadata:
      name: nginx
      labels: 
        app: mypod 
        type: front-end
    spec:
      containers:
        - name: nginx-container 
          image: nginx
  replicas: 3
  selector: 
    matchLabels:
      type: front-end

## NOTES: if you were asked to create a pod or deployment with specific name and image you can simply run the kubectl run command.
Create an NGINX Pod

kubectl run nginx --image=nginx

Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)

kubectl run nginx --image=nginx --dry-run=client -o yaml

Create a deployment

kubectl create deployment --image=nginx nginx

Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)

kubectl create deployment --image=nginx nginx --dry-run=client -o yaml

Generate Deployment YAML file (-o yaml). Don’t create it(–dry-run) and save it to a file.

kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml

Make necessary changes to the file (for example, adding more replicas) and then create the deployment.

kubectl create -f nginx-deployment.yaml

OR

In k8s version 1.19+, we can specify the --replicas option to create a deployment with 4 replicas.

kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml

# Kubernetes Services 
* In K8S, each pods has its own ip address 
* When a service is setup, it allows a stable ip address for each pod

# TYPES OF SERVICES 
Helps in grouping pods together and provides a single interface to access pods in a group. 

## Cluster IP 
* ClusterIP is the default type of service
* It helps to easily deploy a microservices applications in a cluster. 
* Cluster IP is an internal fixed IP created in front of a pod. 
* Service only reachable from within the cluster
* You can expose the Service to the public internet using an {Ingress) or a {Gateway}.
* User uses the following to know the pod to foward too:
      A.  Selector: Selector is specified in the specification files in the service yaml file
  It uses key value pair {app: webapp}

      B. Labels

## Create Service cluster IP 
---
apiVersion: v1
kind: Service
metadata:
  name: backend 
spec:
  type: ClusterIP
  port:
    - targetPort: 80  (Port to forward request to)
      port: 80 
  selector:
  app: myapp
  type: back-end

 OR 

---
apiVersion: v1
kind: Service
metadata:
  name: 
  namespace: default
spec:
  ports:
  - nodePort: 
    port: 
    targetPort: 
  selector:
    name: 
  type:

Command : 
kubectl create -f clusterip.yaml
kubectl get services 

## HEADLESS SERVICE 
* This is used when you need direct communication with individual pods 

## NODE PORT 
* This is not a safe/secured service beacuse you can easily access the pods from the ports.
* Service is accessible on a static port on each worker node in the cluster.
* Make external traffic access on static fixed port on each worker node (Instead of using ingress the browser request will come directly to the worker node at the port that service application defines)
* The port that is exposed is defined in the node port attribute under the specification of the service. 
E.G  spec 
      ports:
        - protocol: TCP 
          nodeport: 3000
* After creating the nodeport service, it will have a cluster ip address and for each ip address it will have a port open where the service is accessible.
* The Kubernetes control plane allocates a port from a range specified by --service-node-port-range flag (default: 30000-32767)
## LOAD BALANCER SERVICE 
* This helps end user's access the pods from just one URL. 
* In a cloud platform the load balancer of AWS will be integrated with the kubernetes cluster. 
* The pods is access externally theough cloud service providers Load balancer.

# NAMESPACES 
* Namespaces are used to organize cluster into virtual sub-cluster. 

## Namespaces in Kubernetes 
1. Default: This namespace is created automatically when the cluster is created. Kubernetes resources are located in the default namespace until new namespaces are created. 

2. Kube-system 
Used for Kubernetes component and should be avaoided. 
Asolate 

3. Kube-public: Resources made avalaible for the public users care created here. 

## NOTES
* To isolate resources in the same cluster, create a diffrent namespace for each environemnt. 

* To automaticlly create a pod in a spsecific namespace, put he namespace in the yaml file to creat the pod. 

## Create a namespace
apiVersion: v1 
kind: Namespace
metadate:
  name: dev

    OR 

kubectl create namespace dev 

## Switch to a particular namespace automatically 
kubectl config set-context $(kubectl config current-context) --namespace=namespance-name

## Create a pods with a specific namespace
kubectl run redis --image=redis --namespace=finance

## View pods in all namespace
kubectl get pods --all-namespaces

# RESOURCE QUOTA 
Limit resources in a namespace. 

## Create a Resource quota
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: dev
spec:
  hard:
    pods: "10"
    requests.cpu: "4" 
    requests.memory: 5Gi
    limits.cpu: "10"
    limits.memory: 10Gi 


# IMPERATIVE VS DECLARATIVE 
Diffrent ways of managing infracturcture:

1. Imperative:  
Specifying what to do and how to do it. 
It also means of instructions written setps by steps 
imperative commands can help in getting one time tasks done quickly, as well as generate a definition template easily. 
## Exmaples of Kubernates command that are imprerative 
kubectl reun --image=nginx nginx 
kubecrl create deployement --image-nginx 
kubectl scale deployment nginx --replivcas=5
kubectl create -f yaml-file

2. Declarative:
Specify what to do but not how to do it. 


## Exmaples of Kubernates command that are Declarative 
