- kubectl create -f "deployment.yml" {Create pod in the default namespace}
- kubectl get all
- kubectl get pods
- kubectl get nodes
- kubectl get rs (Replicaset)
- kubectl get deployment
- kubectl delete pod "name"
- kubectl delete rs "name"
- kubectl describe pods
- kubectl describe rs
- kubectl describe deployment
- kubectl get rs --watch
- kubectl get pod -owide 
- kubectl get pods --namespace=namespance-name {List pods in another namespace}
- kubectl create -f pod.yaml--namespace=namespance-name {Create pod in a specific namespace}
- kubectl get pods --all-namespaces (View pods in all namespace)
- kubectl create namespace <namespace-name> : Create a new namespace
- kubectl config set-context --current --namespace=<namespace-name> : Switch to another namespace and configure



  kubectl Commands 
  create          Create a resource from a file or from stdin
  expose          Take a replication controller, service, deployment or pod and expose it as a new Kubernetes service
  run             Run a particular image on the cluster
  set             Set specific features on objects

Basic Commands (Intermediate):
  explain         Get documentation for a resource
  get             Display one or many resources
  edit            Edit a resource on the server
  delete          Delete resources by file names, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout         Manage the rollout of a resource
  scale           Set a new size for a deployment, replica set, or replication controller
  autoscale       Auto-scale a deployment, replica set, stateful set, or replication controller

Cluster Management Commands:
  certificate     Modify certificate resources.
  cluster-info    Display cluster information
  top             Display resource (CPU/memory) usage
  cordon          Mark node as unschedulable
  uncordon        Mark node as schedulable
  drain           Drain node in preparation for maintenance
  taint           Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe        Show details of a specific resource or group of resources
  logs            Print the logs for a container in a pod
  attach          Attach to a running container
  exec            Execute a command in a container
  port-forward    Forward one or more local ports to a pod
  proxy           Run a proxy to the Kubernetes API server
  cp              Copy files and directories to and from containers
  auth            Inspect authorization
  debug           Create debugging sessions for troubleshooting workloads and nodes
  events          List events

Advanced Commands:
  diff            Diff the live version against a would-be applied version
  apply           Apply a configuration to a resource by file name or stdin
  patch           Update fields of a resource
  replace         Replace a resource by file name or stdin
  wait            Experimental: Wait for a specific condition on one or many resources
  kustomize       Build a kustomization target from a directory or URL

Settings Commands:
  label           Update the labels on a resource
  annotate        Update the annotations on a resource
  completion      Output shell completion code for the specified shell (bash, zsh, fish, or powershell)

Other Commands:
  api-resources   Print the supported API resources on the server
  api-versions    Print the supported API versions on the server, in the form of "group/version"
  config          Modify kubeconfig files
  plugin          Provides utilities for interacting with plugins
  version         Print the client and server version information

Usage:
  kubectl [flags] [options]

  ## Kind commands 
  1. kind delete cluster --name <cluster-name> [Delete cluster]
  2. Create Cluster with Worker Nodes:
      a. Create a Yaml 
      b. Cluster configuration file

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: cluster1
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker

kind create cluster --name=cluster1 --config=nodes.yaml