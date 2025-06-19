# Date:6/12/2025
# AWX 

* AWX stands for Ansible Web eXecutable. 
* It's an open-source, community-supported project that provides a web-based user interface for Ansible automation. 
* AWX is the foundation for the Ansible Automation Platform (formerly known as Ansible Tower) and offers many of the same capabilities
* But does not offers the commercial support and enterprise features that  Red Hat Ansible Automation Platform have. 
* It allows you to run, manage, and schedule Ansible playbooks through a GUI instead of the command line.

## Install Ansible AWX on Kubernetes cMinikube cluster 
* Ansible AWX is installed using the {AWX Operator} on top of a Kubernetes or OpenShift cluster.

* If you dont have a existing cluster, create a new cluster using munukube. 

## Step 1: Create a cluster using minikube
minikube start --driver=qemu2 --nodes 1 --cni calico --cpus=4  --memory=8g --kubernetes-version=v1.31.0 --container-runtime=containerd --addons=ingress 

## Step 2: Enable the addons 
minikube addons list
minikube addons enable metrics-server
minikube dashboard

## Step 3: Deploy the AWS Operator

git clone git@github.com:ansible/awx-operator.git
cd awx-operator

* Find available tags/versions
git tag

* Switch to the required version tag
git checkout tags/2.19.1

* make deploy

Note: 
AWX pod will be up and running  after deploying the AWX Operator.

* Verifiy the pod
kubectl get pod -n awx

## Step 4: Create AWX Deployment
Create an instance for AWX 
* Create a file awx-demo.yaml

---
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx_demo1
spec:
  service_type: nodeport

* Now create the resource.

kubectl apply -f awx-demo.yml 

## Step 5: 
* Get the Admin Password for Ansible AWX
kubectl get secret awx-demo-admin-password -o jsonpath="{.data.password}" | base64 --decode

* Verify the service type (It should be NodePort)
kubectl get svc

## Step 6: 
* Accessing AWX WEBUI – minikube and Nodeport
* Since we used minikube to create our cluster, we have to use the minikuve command to get thw url to access out AWX instance WEBUI

minikube service awx-demo-service --url -n awx

Ref: https://www.techbeatly.com/install-ansible-awx-on-kubernetes/
