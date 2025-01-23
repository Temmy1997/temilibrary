# HELM 
Helm is the package manager for kubernetes. 
Helm provide users with a better way to manage all the kubernets YAML files 
Helm create bundles of yaml files
I can create my own helm chart with helm and push them to heml repositiry. 
Or i can use existing helm chart created by other people. 

## SHARING HELM CHARTS 
PUBLIC Registries 
Private Registerieis. 

## HELM AS A TEMPLATING ENGINE

1. Since we have to create diffrent yaml files for diffrent microservices
2. Helm helps to define command blueprint within all the yaml files 
3. A template yaml file is created for all the yaml fiiles 
4. A values files will be created for all the values in the template file. 

NOTE: 
Vlaues can be defined eith via yaml files or with --set flag 

# Applications across diffrent environment
1. Helm create application chart 
2. IT has all the necessary yaml files 
3. Helm charts use a template approach to deploy applications. 

## HELM STRUCTURE 
DIRECTORY STRUCTURE

mychart/                    - Top level mychart folder ( name of the chart) 
    Chart.yaml              - Contains all the meta infor about chart (name, dependencies, veriosn)
    values/yaml             - Values for the template files 
    charts/                 - Chart dependencies 
    templates/              - where the actual template files 

## Values.yaml files 

imageName: myapp
port: 8080
version: 1.0.0

## Diffrent ways the written yaml fil can be override on the commnad line. 
1. Using --set flag 
heml install --set version=2.0.0

2. helm install --values=my-values.yaml 

## Create Helm Chart

Helm chart folder structuer template: 
nginx-chart/
|-- Chart.yaml
|-- charts
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- deployment.yaml
|   |-- configmap.yaml
|   |-- ingress.yaml
|   |-- service.yaml
|   `-- tests
|       `-- test-connection.yaml
`-- values.yaml

1. .helmignore: It is used to define all the files that we don’t want to include in the helm chart. It works similarly to the .gitignore file.

2. Chart.yaml: It contains information about the helm chart like version, name, description, etc.

3. values.yaml: In this file, we define the values for the YAML templates. (image name, replica count, HPA values, etc)

* Only the values.yaml file changes in each environment. 
* You can override these values dynamically or at the time of installing the chart using --values or --set command.

4. charts: We can add another chart’s structure inside this directory if our main charts have some dependency on others. By default this directory is empty.

5. templates: This directory contains all the Kubernetes manifest files that form an application. These manifest files can be templated to access values from values.yaml file. 

* Helm creates some default templates for Kubernetes objects like deployment.yaml, service.yaml etc, which we can use directly, modify, or override with our files.

    * templates/NOTES.txt: This is a plaintext file that gets printed out after the chart is successfully deployed. 
    
    * templates/_helpers.tpl: That file contains several methods and sub-template. These files are not rendered to Kubernetes object definitions but are available everywhere within other chart templates for use. 

    * templates/tests/: We can define tests in our charts to validate that your chart works as expected when it is installed. 

# HOW TO CREATE HELM CHART 
1. Create a New Helm Chart
    helm create <chart name>

    Using the ls command, list the chart structure:
    ls <chart name>

2. Open the helm chart
   code <chart name>

3. Configure Helm Chart Image Pull Policy 
* Open the values.yaml file in a text editor
* Locate the image values:
* Change the image pullPolicy from IfNotPresent to Always

    ## There are three possible values for the pullPolicy:
        IfNotPresent – Downloads a new version of the image if one does not exist in the cluster.
        Always – Pulls the image on every restart or deployment.
        Latest – Pulls the most up-to-date version available

4. Install the Helm Chart
helm install web-release web/ --values web/values.yaml

## Install the chart to the cluster and if there is some issue it will show the error.
helm install --dry-run my-release <chart name>

## Check the release list using this command:
helm ls 

5. Run the kubectl commands to check the deployment, services, and pods.

kubectl get deployment
kubectl get services
kubectl get configmap
kubectl get pods

6. Upgrade helm 
helm upgrade web-release web/ --values web/values.yaml

7. Deploy the previous chnages 
helm rollback <chart name>

8. Roll back to the specific version
helm rollback <release-name> <revision-number> 

## Validate the Helm Chart
** To make sure that our chart is valid and, all the indentations are fine. Ensure you are inside the chart directory.
        helm lint .



REFRENCES:
https://devopscube.com/create-helm-chart/
