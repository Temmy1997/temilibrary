## Monitoring Cluster Component 
* We monitor the number of nodes, how mnager nodes are heahty, number of pods e.t.c 
* Kubernetes does not come with monotoring solutions such as the following:
1. Metrics server 
2. Prometheus 
3. Elastic stack 
4. DataDog 
4. dynatrace.  

* Kuberntes runs kublet on the nodes 
* The kublet receive or CONTAINER ADVISOR 
* The cAdvisor is repsonsible for retrieving performance metrics from pods and ecposes the mrtrics through the kublet API to make metrics avaible for he metrics server. 

* Command to view cluster performance 
kubectl top node 

* Command to view performamce metrics of pods 
kubectl top pod 

## To deploy metrics-server to monitor the PODs and Nodes. 
1. Pull the git repository for the deployment files.
2. Deploy the metrics-server by creating all the components downloaded.

Run the kubectl create -f . command from within the downloaded repository.

## Website to read:
 How To Install Metrics Server on a Kubernetes:
 https://computingforgeeks.com/how-to-deploy-metrics-server-to-kubernetes-cluster/#google_vignette

# Managing Application Logs 
