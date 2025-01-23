# PROJECTS 

# Kubernetes Project
Create a simple web app using nginx/apache and access it on your browser using the following method.
use cluster ip service and access the website from your browser
use loadbalancer and nodeport service also


## Solution:

1. Create an index.html file

2. Create a Dockerfile to build a custom Apache image with your index.html file. 

Dockerfile
Copy code

FROM httpd:2.4
COPY ./index.html/ /usr/local/apache2/htdocs/

NOTE: Place your custom index.html file in the same directory as the 


3. Build the Docker image and push it to a container registry of your choice. 
* Replace <your-registry> with the actual registry URL.


docker build -t temmy1997/temmy-apache:latest .
docker push temmy1997/temmy-apache:latest

4. Create a Deployment that uses your custom Apache image. 
Create a Yaml file " apache-deployment.yaml" 

apiVersion: apps/v1
kind: Deployment
metadata:
  name: apache-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: apache
  template:
    metadata:
      labels:
        app: apache
    spec:
      containers:
      - name: apache
        image: temmy1997/temmy-apache:latest
        ports:
        - containerPort: 9090

Apply the deployment to your cluster:
kubectl apply -f apache-deployment.yaml

5. Create a ClusterIP service to expose the Apache deployment. 

apiVersion: v1
kind: Service
metadata:
  name: apache-service
spec:
  selector:
    app: apache
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9090
  type: ClusterIP

* Apply the service to your cluster:
kubectl apply -f apache-service.yaml

Note: ClusterIP services are not directly accessible from outside the Kubernetes cluster, and port forwarding typically doesn't apply to ClusterIP services. ClusterIP services are meant for internal communication within the cluster.

## NodePort 

1. Change your service type to NodePort
* This will expose your service on a high-numbered port on all nodes in your cluster.


apache-deployment-9495686bb-pd8ww
31645