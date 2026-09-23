# RANCHER 
Rancher is a platform that simplifies the deployment and management of Kubernetes clusters. 

It provides a user-friendly interface to manage multiple Kubernetes clusters across different environments.

Rancher helps with tasks like cluster provisioning, monitoring, and scaling, making it easier for teams to work with Kubernetes. 

## Features of the Rancher API Server
The Rancher API server is built on top of an embedded Kubernetes API server and an etcd database. It implements the following functionalities:

Authorization and Role-Based Access Control
User management: The Rancher API server manages user identities that correspond to external authentication providers like Active Directory or GitHub, in addition to local users.
Authorization: The Rancher API server manages access control and security policies.


## How to deploy and setup Rancher Server
There are following guides to deploy and provision Rancher server: 
1. AWS (uses Terraform)
2. AWS Marketplace (uses Amazon EKS)
3. Azure (uses Terraform)
4. DigitalOcean (uses Terraform)
5. GCP (uses Terraform)
6. Hetzner Cloud (uses Terraform)
7. Vagrant
8. Equinix Metal
9. Outscale (uses Terraform)

For thie project, we will install Rancher on manaually 

## How to install Rancher on a linux server 
Prerequisites:
1. Linux server (or a cluster of servers).
2. Docker installed on the server.
3. Ports 80 and 443 open for Rancher communication.

STEP 1: Prepare a Linux Host
Prepare a Linux host with any supported Linux distribution including openSUSE and at least 4GB of memory. Install a supported version of Docker on the host.

STEP 2: Start the server
To install and run Rancher, execute the following Docker command on your host:

sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher

To access the Rancher server UI, open a browser and go to the hostname or address where the container was installed. You will be guided through setting up your first cluster. To get started quickly, have a look at out additional resources and getting started guide.

REF: https://www.rancher.com/quick-start

# HOW TO INSTALL RANCHER ON A KUBERNETES CLUSTER 

## Prerequisites:
Kubernetes Cluster

kubectl: Make sure kubectl is installed on your machine, and you have configured it to connect to your Kubernetes cluster.

1. Create a namespace for Rancher
kubectl create namespace rancher-namespace

2. Add the Helm chart repository that contains charts to install Rancher.
helm repo add rancher https://releases.rancher.com/server-charts/latest


3. Choose your SSL Configuration
The Rancher management server is designed to be secure by default and requires SSL/TLS configuration.

4. Install cert-manager (version 1.11.0)
This step is only required to use certificates issued by Rancher's generated
You should skip this step if you are bringing your own certificate files.

## STEP1 : kubectl create namespace cert-manager

## STEP 3: If you have installed the CRDs manually instead of with the `--set installCRDs=true` option added to your Helm install command, you should upgrade your CRD resources before upgrading the Helm chart:
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.5.3/cert-manager.c
rds.yaml

## STEP 2: Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

## STEP 3: Update your local Helm chart repository cache
helm repo update

## STEP 4: Install the cert-manager Helm chart

helm install cert-manager-new jetstack/cert-manager \
  --namespace cert-manager



5. Install the Rancher chart
helm install rancher rancher/rancher \
  --namespace rancher-namespace \
  --set hostname=rancher.my.org \
  --set bootstrapPassword=admin


  helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=HOSTNAME --set bootstrapPassword=PASSWORD --set ingress.tls.source=letsEncrypt --set letsEncrypt.ingress.class=nginx

  helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set bootstrapPassword=admin

