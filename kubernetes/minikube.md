# Minikube 
* Minikube is a tool that lets you run a Kubernetes cluster locally — on your laptop or desktop.
* This is a one node kubernetes cluster that runs on alocak machine. 
* It is used for testing purposes. 
* Helps to manage k8s cluster. 

## What is Minikube?

* Since Kubernetes is usually run in big cloud environments (like AWS, Azure, or GCP), Minikube is perfect for learning and testing on your own computer.

## What Is a Minikube Cluster?
* A Minikube cluster is just a small, single-node Kubernetes environment created by Minikube.

* It’s like having your own private, tiny version of Kubernetes to practice on.

## How They Work Together:
1. You install Minikube on your laptop.
2. It creates a Kubernetes cluster locally (in a virtual machine or container).
3. You can deploy apps into the cluster and practice Kubernetes commands.

## Example Use Case:
Want to test deploying a website in Kubernetes?
1. Start a Minikube cluster: minikube start
2. Deploy your app: kubectl apply -f myapp.yaml
3. View it in the browser: minikube service myapp-service

