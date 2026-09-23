* Openshift is a managed enterprise kubernetws cluster 
* It is build on top of kubernets offerinf additional tools and features:

    1. Application development
    2. Continuous integration/continuous delivery (CI/CD)
    3. Infrastructure automation
    4. Security and policy enforcement

* crc cli is the command line tool uisng by opeshift 
* It is used to manage the Openshift cluster. 

# run rhaap in openshift local

# first install Openshift
- openshift local previously known as crc
- install podman and kvm 
- download openshift and secret from https://console.redhat.com/openshift/create/local
- run installer and verify crc is in cli
```
crc version
crc setup
crc status
crc config set pull-secret-file pull-secret
code ~/.crc
crc start
crc config view
crc start -p pull-secret
```
- you will see output 
```
Started the OpenShift cluster.

The server is accessible via web console at:
  https://console-openshift-console.apps-crc.testing

Log in as administrator:
  Username: kubeadmin
  Password: osF4Z-EQHUX-ZyG25-GZYEE

Log in as user:
  Username: developer
  Password: developer

Use the 'oc' command line interface:
  $ eval $(crc oc-env)
  $ oc login -u developer https://api.crc.testing:6443
```
- oc is the kubectl for openshift cluster
- add to .zshrc output of crc oc-env
- crc console --credentials
- crc cleanup all

## summary
openshift cluster is a redhat k8s cluster that runs in a k8s cluster